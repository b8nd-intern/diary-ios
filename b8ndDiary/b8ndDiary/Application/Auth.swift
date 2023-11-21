//
//  Auth.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation

public class Auth {
    
    internal static func get(_ tokenType: AuthType) -> Bool? {
        return UserDefaults.standard.bool(forKey: String(describing: tokenType))
    }
    internal static func save(_ tokenType: AuthType, _ value: Bool) {
        UserDefaults.standard.set(value, forKey: String(describing: tokenType))
    }

    internal static func remove(_ tokenType: AuthType) {
        UserDefaults.standard.removeObject(forKey: String(describing: tokenType))
    }
}

enum AuthType {
    case isLogin
}
