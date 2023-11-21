//
//  AppViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation
import GoogleSignIn

class AppViewModel : ObservableObject {
    @Published var isLogin = Auth.get(.isLogin) ?? false
    
    func save(_ value: Bool) {
        Auth.save(.isLogin, value)
        GIDSignIn.sharedInstance.signOut()
        isLogin = Auth.get(.isLogin) ?? false
    }
}
