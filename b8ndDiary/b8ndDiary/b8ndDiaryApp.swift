//
//  b8ndDiaryApp.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/09/21.
//

import SwiftUI
import GoogleSignIn

@main
struct b8ndDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            GoogleSignIn(userData: UserData(url: nil, name: "", email: ""))
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
