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



struct GoogleSignIn: View {
    // 로그인 상태
    @State private var isLogined = false
    // 유저 데이터
    @State private var userData: UserData?

    @State private var isAlert = false
    
    @State private var idToken = String()
    
    @State private var fcmToken = String()
    var body: some View {
        NavigationStack {
            Login()
            Spacer()
            ZStack {
                GoogleSignInButton(
                    scheme: .light,
                    style: .wide,
                    action: {
                        print(googleLogin())
                    })
                .frame(width: 300, height: 60, alignment: .center)
                .padding(20)
            }
            .navigationDestination(isPresented: $isLogined, destination: {HomeView(userData: userData ?? UserData(url: nil, name: "", email: "")) })
            
        }
        .onAppear(perform: {
            // 로그인 상태 체크
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
            guard let idToken = signInResult?.user.idToken?.tokenString else {
                return
            }
            
            Messaging.messaging().token { token, error in
                           if let error = error {
                               print("Error fetching FCM token: \(error)")
                           } else if let token = token {
                               self.fcmToken = token
                           }
                       }

            
            guard let profile = result.user.profile else { return }
            let data = UserData(url: profile.imageURL(withDimension: 180), name: profile.name, email: profile.email)
            
            userData = data
            isLogined = true
            self.idToken = idToken
        }
    }
}
#Preview {
    GoogleSignIn()
}
