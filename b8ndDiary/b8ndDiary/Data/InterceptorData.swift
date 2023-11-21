//
//  Interceptor.swift
//  b8nd
//
//  Created by 조영우 on 10/30/23.
//

import Foundation
import Alamofire

struct InterceptorData: Codable {
    let accessToken: String
}

final class Interceptor: RequestInterceptor {
    
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Config.apiKey) == true,
              let accessToken = Token.get(.accessToken) else {
                  completion(.success(urlRequest))
                  return
              }
        var urlRequest = urlRequest
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 5
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetryWithError(error))
            return
        }
        if let refreshToken = Token.get(.refreshToken) {
            AF.request("\(Config.apiKey)/auth/refresh",
                       method: .post,
                       parameters: ["refreshToken": "Bearer \(refreshToken)"],
                       encoding: JSONEncoding.default,
                       headers: ["Content-Type": "application/json"]
            ) { $0.timeoutInterval = 5 }
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success:
                        let decoder: JSONDecoder = JSONDecoder()
                        guard let value = response.value else { return }
                        guard let result = try? decoder.decode(InterceptorData.self, from: value) else { return }
                        Token.save(.accessToken, result.accessToken)
                        completion(.retry)
                    case .failure(let error):
                        print("통신 오류!\nCode:\(error._code), Message: \(error.errorDescription!)")
                        Token.remove(.accessToken)
                        Token.remove(.refreshToken)
                        completion(.doNotRetryWithError(error))
                        exit(0)
                    }
                }
        }
    }
}
