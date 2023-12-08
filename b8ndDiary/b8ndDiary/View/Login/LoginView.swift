//
//  GoogleSignIn.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 2023/10/04.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseMessaging
import FirebaseAuth
import Alamofire
import FirebaseCore


struct LoginView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    
    // 유저 데이터
    @State private var userData: UserData?

    @State private var isAlert = false
    
    @State private var idToken = String()
    
    @State private var fcmToken = String()
    
    struct GoogleResponse : Codable {
        let accessToken : String
        let refreshToken : String
        let isFirst : Bool
    }

    var body: some View {
        NavigationStack {
            LaunchView()
            Spacer()
            GoogleSignInButton(
                scheme: .light,
                style: .wide,
                action: {
                    googleLogin()
                })
            .frame(width: 300, height: 60, alignment: .center)
            .padding(20)
            .navigationDestination(isPresented: $appViewModel.isLogin, destination: {
                HomeView(userData: userData ?? UserData(url: nil, name: "", email: ""))
//                    .environmentObject(info)
            })
        }
        .onAppear {
            checkState()
        }
        .alert(LocalizedStringKey("로그인 실패"), isPresented: $isAlert) {
            Text("확인")
        } message: {
            Text("다시 시도해주세요")
        }
    }
    
    // 상태 체크
    func checkState() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // 로그아웃 상태
                print("Not Sign In")
            } else {
                // 로그인 상태
                guard let profile = user?.profile else { return }
                let data = UserData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
                userData = data
                appViewModel.save(true)
            }
        }
    }
    
    // 구글 로그인
    func googleLogin() {
        // rootViewController
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        // 로그인 진행
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            guard let result = signInResult else {
                isAlert = true
                return
            }
            
            // 구글 로그인 성공 후 ID 토큰 가져오기
            guard let idToken = signInResult?.user.idToken?.tokenString else {
                return
            }
            
     
            Messaging.messaging().token { token, error in
                if let error = error {
                    print("Error fetching FCM token: \(error)")
                } else if let token = token {
                    self.fcmToken = token
                    print("FCM Token: \(token)")
                }
            }

            // FCM 토큰이 아직 필요하지 않다면 아래의 라인을 주석 처리하세요
            self.fcmToken = ""
            self.idToken = idToken
            
            // FCM 토큰과 ID 토큰을 서버로 보내는 함수 호출
            sendTokensToServer {
                
                guard let profile = result.user.profile else { return }
                let data = UserData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
                
                userData = data            
                appViewModel.save(true)
            }
        }
    }

    // FCM 토큰과 ID 토큰을 서버로 보내는 함수
    func sendTokensToServer(callback: @escaping () -> Void) {
        Task {
            let headers: HTTPHeaders = [
                "id_token": idToken,
                "fcm_token": "ㅎㅇ",
                "Accept": "application/json"
            ]
            
            do {
                let response = try await HttpClient.request(
                    HttpRequest(url: "auth/login/google",
                                             method: .post,
                                             headers: headers,
                                             model: Response<GoogleResponse>.self))
                print(response.data!.accessToken)
                print(response.data!.refreshToken)
                Token.save(.accessToken, response.data!.accessToken)
                Token.save(.refreshToken, response.data!.refreshToken)
                callback()
            } catch APIError.responseError(let statusCode) {
                print("서버 응답 오류: HTTP 상태 코드; \(statusCode)")
            } catch {
                print("서버 응답 오류: \(error)")
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
        func application(_ application: UIApplication,
                         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
            
            // 파이어베이스 설정
            FirebaseApp.configure()
            
            // 앱 실행 시 사용자에게 알림 허용 권한을 받음
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
            
            // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
            application.registerForRemoteNotifications()
            
            // 파이어베이스 Meesaging 설정
            Messaging.messaging().delegate = self
            
            return true
        }
    }

   

        }




