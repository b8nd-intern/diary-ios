//
//  LoginViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 12/8/23.
//

import Foundation
import Alamofire

struct GoogleResponse : Codable {
    let accessToken : String
    let refreshToken : String
    let isFirst : Bool
}

class LoginViewModel : ObservableObject {
    
    // FCM 토큰과 ID 토큰을 서버로 보냅니다
    func sendTokensToServer(idToken: String, callback: @escaping () -> Void) {
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
    
}
