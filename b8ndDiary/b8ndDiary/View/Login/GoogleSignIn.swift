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


struct GoogleSignIn: View {
    // 로그인 상태
    @State private var isLogined = false
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
//    
//    public func sendTokensToServer(/*_ idToken: String*/) async {
//        Task{
//            //        if let uid = Auth.auth().currentUser?.uid {
//            let headers: HTTPHeaders = [
//                "id_token": idToken,
//                "fcm_token": fcmToken,
//                "Accept": "application/json"
//            ]
//            
//            do {
//                let response = try await HttpClient.request(
//                    httpRequest: HttpRequest(url: "http://15.164.163.4/auth/login/google",
//                                             method: .post,
//                                             headers: headers,
//                                             model: BaseResponse<GoogleResponse>.self))
//                
//                print("서버 응답: \(response)")
//                
//            } catch APIError.responseError(let statusCode) {
//                print("서버 응답 오류: HTTP 상태 코드 \(statusCode)")
//            } catch {
//                print("서버 응답 오류: \(error)")
//            }
//            //        }
//        }
//    }


    var body: some View {
        NavigationStack {
            Login()
            Spacer()
            ZStack {
                GoogleSignInButton(
                    scheme: .light,
                    style: .wide,
                    action: {
//                        print(googleLogin())
                        googleLogin()
                        
               
                        
                    })
                .frame(width: 300, height: 60, alignment: .center)
                .padding(20)
            }
            .navigationDestination(isPresented: $isLogined, destination: {HomeView(userData: userData ?? UserData(url: nil, name: "", email: "")) })
            
        }
        .onAppear(perform: {
            // 로그인 상태 체크
//            Task{
//                await sendTokensToServer()
//            }
            checkState()
        })
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
                isLogined = true
                print(isLogined)
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
            
            // FCM 토큰 가져오기 (이 부분을 주석 해제하고 사용하려면 알맞게 수정하세요)
    //        Messaging.messaging().token { token, error in
    //            if let error = error {
    //                print("Error fetching FCM token: \(error)")
    //            } else if let token = token {
    //                self.fcmToken = token
    //                print("FCM Token: \(token)")
    //
    //                // FCM 토큰과 ID 토큰을 서버로 보내는 함수 호출
    //                sendTokensToServer()
    //            }
    //        }

            // FCM 토큰이 아직 필요하지 않다면 아래의 라인을 주석 처리하세요
            self.fcmToken = ""
            
            // FCM 토큰과 ID 토큰을 서버로 보내는 함수 호출
            sendTokensToServer()

            guard let profile = result.user.profile else { return }
            let data = UserData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
            
            userData = data
            isLogined = true
            self.idToken = idToken
            print("ID Token: \(self.idToken)")
        }
    }

    // FCM 토큰과 ID 토큰을 서버로 보내는 함수
    func sendTokensToServer() {
        Task {
            let headers: HTTPHeaders = [
                "id_token": idToken,
                "fcm_token": fcmToken,
                "Accept": "application/json"
            ]
            
            do {
                let response = try await HttpClient.request(
                    httpRequest: HttpRequest(url: "http://15.164.163.4/auth/login/google",
                                             method: .post,
                                             headers: headers,
                                             model: BaseResponse<GoogleResponse>.self))
                
                print("서버 응답: \(response)")
                
            } catch APIError.responseError(let statusCode) {
                print("서버 응답 오류: HTTP 상태 코드 \(statusCode)")
            } catch {
                print("서버 응답 오류: \(error)")
            }
        }
    }

    }


