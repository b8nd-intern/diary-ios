//
//  RecordResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/22/23.
//

import Foundation

struct RecordResponse<T: Codable>: Codable {
    let status: Int
    let message: String
    let data: [T]
}

struct YearResponse: Codable {
    let date: String
    let isDone: Bool
}
