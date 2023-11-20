//
//  Config.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/20/23.
//

import Foundation

final class Config {
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY")! as! String
}
