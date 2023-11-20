//
//  BaseResponse.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/2/23.
//

import Foundation

<<<<<<< HEAD:b8ndDiary/b8ndDiary/Data/Response.swift
struct Response<T: Codable>: Codable {
    
=======
struct BaseResponse<T: Codable>: Codable {
>>>>>>> login:b8ndDiary/b8ndDiary/Data/BaseResponse.swift
    let status: Int
    let message: String
    let data: T?
}
