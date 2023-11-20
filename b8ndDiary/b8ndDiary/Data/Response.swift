//
//  BaseResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/2/23.
//

import Foundation


struct Response<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: T
}
