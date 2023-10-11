//
//  DiaryCell.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct DiaryCell: View {
    
    @State var data: String = ""
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Colors.Blue2.color)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            Image("SmileEmoji")
                            Spacer()
                        }
                        .padding(.top, 8)
                        
                        Text("\(data)")
                            .lineLimit(4)
                            .foregroundColor(Colors.Black1.color)
                        
                        Spacer()
                    }
                    .padding(.leading, 7)
                }
        }
    }
}
