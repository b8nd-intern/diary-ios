//
//  PostViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/20/23.
//

import Foundation
import SwiftUI


class PostViewModel : ObservableObject {
    
    @Published var text: String = ""
    @Published var publicState: Bool = true
    @Published var backgroundColor: Color = Colors.Blue1.color
    @Published var selectedEmoji: String = "DefaultEmoji"
    
    @MainActor
    func post() {
        Task {
            do {
                let response = try await HttpClient.request(
                    HttpRequest(url: "post/create",
                                method: .post,
                                params: ["content": text,
                                         "color":backgroundColor.description,
                                         "emoji":selectedEmoji,
                                         "isSecret":publicState
                                        ],
                                model: Response<String>.self))
                print(response.data!)
            } catch APIError.responseError(_) {
                
            }
        }
    }
}
