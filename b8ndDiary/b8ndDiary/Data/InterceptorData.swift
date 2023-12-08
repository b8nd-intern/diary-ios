//
//  Interceptor.swift
//  b8nd
//
//  Created by 조영우 on 10/30/23.
//

import Foundation
import Alamofire
import GoogleSignIn


final class Interceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("adapt")
        print("url -", urlRequest.url ?? "")
        print(Token.get(.accessToken) ?? "")
        guard let accessToken = Token.get(.accessToken) else {
            completion(.success(urlRequest))
            print("interceptor.adapt - invalid access Token")
            return
        }
        
        print("interceptor.adapt - insert access token")
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(String(accessToken))", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 5
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("interceptor.retry - start")
        guard let response = request.task?.response as? HTTPURLResponse else {
            return
        }
        
        print("interceptor.retry -", response.statusCode)
        print(Token.get(.refreshToken) ?? "")
        let refreshCode = 403
        guard response.statusCode == refreshCode else {
            print("interceptor.retry -", error)
            completion(.doNotRetryWithError(error))
            return
        }
        
        if let refreshToken = Token.get(.refreshToken) {
            AF.request("\(Config.apiKey)/auth/refresh",
                       method: .post,
                       parameters: ["refreshToken": refreshToken],
                       encoding: JSONEncoding.default,
                       headers: ["Content-Type": "application/json"]
            ) { $0.timeoutInterval = 5 }
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success:
                        let decoder: JSONDecoder = JSONDecoder()
                        guard let value = response.value else { return }
                        guard let result = try? decoder.decode(Response<TokenResponse>.self, from: value) else { return }
                        print("interceptor.retry -", result.data?.accessToken)
                        Token.save(.accessToken, result.data?.accessToken ?? "")
                        completion(.retry)
                    case .failure(let error):
                        print("통신 오류!\nCode:\(error._code), Message: \(error.errorDescription!)")
                        Token.remove(.accessToken)
                        Token.remove(.refreshToken)
                        if error.responseCode == 401 {
                            GIDSignIn.sharedInstance.signOut()
                        }
                        completion(.doNotRetryWithError(error))
                    }
                }
        }
    }
}
