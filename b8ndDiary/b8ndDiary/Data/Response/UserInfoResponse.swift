//
//  UserInfoResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/27/23.
//

import Foundation

struct UserInfoResponse<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: T
}

struct UserInfo: Codable {
    let name : String
    let images : String
    let userId: String
    let dates: [Int]

}
