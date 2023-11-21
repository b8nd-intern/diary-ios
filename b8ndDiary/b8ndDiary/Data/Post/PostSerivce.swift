//
//  PostSerivce.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/15/23.
//

import Foundation

class PostSerivce {
    
    static func getList() async throws -> Response<[DataModel]> {
        
        let response = try await HttpClient.request(HttpRequest(url: "post/list", method: .get, model: Response<[DataModel]>.self))
        
        return response
    }
    
    static func getTopSevenList() async throws -> Response<[DataModel]> {
        let response = try await HttpClient.request(HttpRequest(url: "post/topSeven", method: .get, model: Response<[DataModel]>.self))
        return response
    }
    
}
