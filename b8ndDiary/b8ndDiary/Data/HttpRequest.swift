//
//  HttpRequest.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/2/23.
//

import Foundation
import Alamofire

// 추상화
struct HttpRequest <T: Decodable> {
    var url: String
    var method: HTTPMethod
    var params: [String: Any]? = nil
    var headers: HTTPHeaders = ["Accept": "application/json"]
    var model: T.Type
}
