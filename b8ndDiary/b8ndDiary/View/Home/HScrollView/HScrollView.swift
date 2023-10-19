//
//  HScrollView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct HScrollView: View {
    
    @Binding var diaryContent: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0...3, id: \.self) { _ in
                    Spacer()
                    Rectangle()
                        .frame(width: 200, height: 225)
                        .foregroundColor(Colors.Yellow1.color)
                        .overlay {
                            Text("\(diaryContent)")
                                .foregroundColor(Colors.Black1.color)
                        }
                    Spacer()
                }
            }
            .padding(.horizontal, 80)
        }
    }
}
