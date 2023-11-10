//
//  b8ndDiaryApp.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/09/21.
////
//


import SwiftUI
import Firebase
import GoogleSignIn
import Foundation
import UserNotifications
import FirebaseMessaging
import Alamofire


@main
struct b8ndDiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            GoogleSignIn()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
class AppDelegate: NSObject, UIApplicationDelegate {
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
        // FCM 등록
        application.registerForRemoteNotifications()
        
        // Messaging 설정
        Messaging.messaging().delegate = self
        
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 백그라운드에서 푸시 알림을 탭했을 때 실행
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner])
    }

    
}

extension AppDelegate: MessagingDelegate {
    
    // 파이어베이스 MessagingDelegate 설정
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) async {
        //파이어 베이스 토큰 출력
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )

        
        // 서버로 FCM 토큰과 ID 토큰 전송
        await sendTokensToServer(fcmToken)
    }
}
struct Response : Codable {
    let accessToken : String
    let refreshToken : String
}


private func sendTokensToServer(_ fcmToken: String?) async {
    guard let fcmToken = fcmToken else { return }
    // ID 토큰 가져오기
    if let idToken = Auth.auth().currentUser?.uid {
        print(idToken)
        let parameters = [
            "fcmToken": fcmToken,
            "idToken": idToken
        ]
        do {
            let httpResponse = try await HttpClient.request(httpRequest: HttpRequest(url: "https://15.164.163.4", method: .post, params :parameters, model: BaseReponse<Response>.self))
        }  catch APIError.responseError(let e) {
            print(e)
        } catch (let e) {
            print(e)
        }
    }
}

func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.list, .banner])
}


