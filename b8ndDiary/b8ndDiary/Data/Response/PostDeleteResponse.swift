//
//  PostdeleteResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/28/23.
//

import Foundation

struct PostDeleteResponse: Codable {
    let postId : [Int]
    let userId: String
}
