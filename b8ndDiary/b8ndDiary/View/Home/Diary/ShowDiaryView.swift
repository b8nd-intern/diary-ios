//
//  ShowDiaryView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ShowDiaryView: View {
    
    @Binding var isClicked: Bool
    @Binding var clickedContent: String
    
    @Binding var day: Int
    
    var diaryContent: [String] = ["오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 행복했다. 그리고 나중에", "개발을 했다1", "개발을 했다2", "개발을 했다3", "개발을 했다4"]
    
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
