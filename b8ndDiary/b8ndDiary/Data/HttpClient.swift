//
//  HttpClient.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/2/23.
//

import SwiftUI
import Alamofire

final class HttpClient {
    
    // session
    private static let session: Session = {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        let interceptor = Interceptor()
        return Session(configuration: configuration,
                       interceptor: interceptor)
    }()
    
    /// 안드든 웹이든 대략적인  http 통신 구현 방법은
    /// 1.  Http요청 객체 생성
    /// 2. 보낸다. (model -> json)
    /// 3. 받는다. (json -> model)
    /// 4. 받은 데이터로 알잘딱 or 에러 처리
    ///
    ///  이럼.
    
    static func request<T: Codable>(httpRequest: HttpRequest<T>) async throws -> T {
        
        let request = session.request("https://koreanjson.com/\(httpRequest.url)",
                                      method: httpRequest.method,
                                      parameters: httpRequest.params,
                                      encoding: httpRequest.method == .get ? URLEncoding.default : JSONEncoding.default,
                                      headers: httpRequest.headers)
        let dataTask = request.serializingDecodable(httpRequest.model)
        switch await dataTask.result {
            
        case .success(let value):
            guard let response = await dataTask.response.response, (200...299).contains(response.statusCode) else {
                throw await APIError.responseError(dataTask.response.response!.statusCode)
            }
            return value
            
        case .failure(let error):
            throw APIError.transportError(error)
        }
    }
}

enum APIError: Error {
    case transportError(Error)
    case responseError(Int)
    case unknownError

    var localizedDescription: String {
        switch self {
        case .transportError(let error):
            return "네트워크 전송 오류: \(error.localizedDescription)"
        case .responseError(let statusCode):
            return "서버 응답 오류: HTTP 상태 코드 \(statusCode)"
        case .unknownError:
            return "알 수 없는 오류가 발생했습니다."
        }
    }
}

