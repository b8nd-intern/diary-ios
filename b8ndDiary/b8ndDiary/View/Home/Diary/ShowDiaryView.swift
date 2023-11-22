//
//  ShowDiaryView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ShowDiaryView: View {
    
    @Binding var isClicked: Bool
    @Binding var clickedContent: DataModel?
    
    @Binding var day: Int
    
    let diaryContent: [DataModel]
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(diaryContent, id: \.self) { content in
                Button {
                    isClicked = true
                    clickedContent = content
                } label: {
                    DiaryCell(data: content)
                        .frame(width: 150, height: 150)
                }
            }
        }
    }
}
