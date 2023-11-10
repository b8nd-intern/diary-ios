//
//  AccessTokenModel.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/6/23.
//

import Foundation
import Alamofire


struct RefreshTokenRequest: Codable {
    let refreshToken: String
}



struct BaseReponse<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: T
}
struct RefreshTokenResponse: Codable {
    let accessToken: String
}


//class AccessTokenModel: ObservableObject {
func AccessToken() async {
    do {
        let body : Parameters = [
            "refreshToken": "string"
        ]
        
        let httpResponse = try await HttpClient.request(httpRequest: HttpRequest(url: "https://15.164.163.4", method: .post, params :body, model: BaseReponse<RefreshTokenResponse>.self))
        
        
        
    }  catch APIError.responseError(let e) {
        print(e)
    } catch (let e) {
        print(e)
    }
}
//}





