//
//  DayView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct DayView: View {
    
    @Binding var day: Int
    
    var dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    var body: some View {
        ForEach(0..<7, id: \.self) { i in
            Button {
                day = i
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 31.54, height: 33)
                    .foregroundColor(Colors.Gray2.color)
                    .overlay {
                        Text("\(dayList[i])")
                            .foregroundColor(Colors.Gray3.color)
                    }
            }
        }
    }
}
