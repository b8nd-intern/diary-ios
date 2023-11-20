//
//  Config.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/20/23.
//

import Foundation

final class Config {
    static let apiKey = getString("API_KEY")
    static let testToken = getString("TEST_TOKEN")
    
    static func getString(_ key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as! String
    }
}
