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
    func post(complete: @escaping () -> Void, 
              error: @escaping () -> Void,
              error2: @escaping () -> Void
    ) {
        Task {
            do {
                print(text, backgroundColor.description, selectedEmoji, publicState)
                let response = try await HttpClient.request(
                    HttpRequest(url: "post/create",
                                method: .post,
                                params: ["content": text,
                                         "color": Color.toString(backgroundColor),
                                         "emoji":selectedEmoji,
                                         "isSecret":publicState],
                                model: Response<String>.self))
                print("post -", response.data ?? "")
                complete()
            } catch APIError.responseError(let e) {
                print(e)
                error()
            } catch APIError.transportError {
                error2()
            }
        }
    }
}
