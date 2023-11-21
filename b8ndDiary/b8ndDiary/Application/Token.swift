//
//  Token.swift
//  b8nd
//
//  Created by 조영우 on 2023/10/06.
//

import Foundation

public class Token {
    
    internal static func get(_ tokenType: TokenType) -> String? {
        return UserDefaults.standard.string(forKey: String(describing: tokenType))
    }

    internal static func save(_ tokenType: TokenType, _ value: String) {
        UserDefaults.standard.set(value, forKey: String(describing: tokenType))
    }

    internal static func remove(_ tokenType: TokenType) {
        UserDefaults.standard.removeObject(forKey: String(describing: tokenType))
    }
}

enum TokenType {
    
    case accessToken
    case refreshToken
}
