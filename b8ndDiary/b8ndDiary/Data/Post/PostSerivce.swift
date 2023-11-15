//
//  PostSerivce.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/15/23.
//

import Foundation

class PostSerivce {
    
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY")!
    
    static func getList() async throws -> Response<[DataModel]> {

        let response = try await HttpClient.request(httpRequest: HttpRequest(url: "http://\(String(describing: apiKey))/post/list", method: .get, model: Response<[DataModel]>.self))

        return response
    }
    
}
