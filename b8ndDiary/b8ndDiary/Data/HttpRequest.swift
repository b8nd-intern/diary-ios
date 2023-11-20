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
    var headers: HTTPHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
//                                , "Authorization" : "Bearer eyJKV1QiOiJBQ0NFU1MiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJiNGQxMGQ1Ni01ZWI0LTRkZmMtOGQzNS1jZjk2MGE5NzExOWIiLCJBdXRob3JpemF0aW9uIjoiVVNFUiIsImlhdCI6MTY5OTE0ODgzMiwiZXhwIjo4ODA5OTE0ODgzMn0.TbaXSAJBrkQftT35y4rzBA4qjZptBA_MW9ycHoIG3qNXPpXAdqP-ovfI8AkBCpfjmTYn7z3nzyoldSVWZMNNiA"]
//    var model: T.Type
}
