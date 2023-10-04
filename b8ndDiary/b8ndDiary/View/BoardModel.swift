//
//  BoardModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/09/22.
//

import Foundation
import SwiftUI

struct TodoModel {
    var id: Int
    var todo: String
    var createdAt: Date
    var position: Int
}

struct TodoRequest {
    let todo: String
}


struct TodoResponse {
    var id: Int
    var todo: String
    var createdAt: Date
}

let dummyLst = [
    TodoModel(id: 0, todo: "취업하기", createdAt: Date(), position: 2),
    TodoModel(id: 1, todo: "돈벌기", createdAt: Date(), position: 0),
    TodoModel(id: 2, todo: "놀기", createdAt: Date(), position: 1),
    TodoModel(id: 3, todo: "떠나기", createdAt: Date(), position: 3)
]

struct TodoListView: View {
    var body: some View {
        ScrollView {
            ForEach(dummyLst, id: \.id) { todo in
                
            }
        }
    }
}

class TodoViewModel: ObservableObject {
    
}
