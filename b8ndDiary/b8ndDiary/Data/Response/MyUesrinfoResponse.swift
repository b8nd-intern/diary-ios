//
//  MyUesrinfoResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/28/23.
//

import Foundation
struct MyUserInfoResponse: Codable {
    let name: String
    let images: String
    let userId: String
    let dates: [Int]
}
