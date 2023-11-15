//
//  PostSerivce.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/15/23.
//

import Foundation

class PostSerivce {
    
    static func getList() async throws -> Response<[DataModel]> {
        print("1")
        let response = try await HttpClient.request(httpRequest: HttpRequest(url: "http://15.164.163.4/post/list", method: .get, model: Response<[DataModel]>.self))
        print("2")
        return response
    }
    
}
