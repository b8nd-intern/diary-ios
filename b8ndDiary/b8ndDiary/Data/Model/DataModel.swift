//
//  DataModel.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/15/23.
//

import Foundation

struct DataModel: Codable {
    
    let postId: Int
    let content, color, emoji, name: String
    let userId: String
    let isSecret: Bool
}
