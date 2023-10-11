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
    
    @EnvironmentObject var content: DiaryContent
    
    // 날짜 선택 후 내용 가져오는 함수
    func SelectDay(_ day: Int) -> [String] {
        switch day {
        case 0: return content.monContent
        case 1: return content.tueContent
        case 2: return content.wedContent
        case 3: return content.thuContent
        case 4: return content.friContent
        case 5: return content.satContent
        case 6: return content.sunContent
        default: return []
        }
    }
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(SelectDay(day), id: \.self) { content in
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
