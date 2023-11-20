//
//  baseResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/20/23.
//

import Foundation


struct baseResponse<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: T
}
