//
//  BaseResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/2/23.
//

import Foundation

struct BaseResponse<T: Decodable> {
    let status: Int
    let message: String
    let data: T
}