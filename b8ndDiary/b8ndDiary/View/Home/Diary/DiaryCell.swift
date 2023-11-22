//
//  DiaryCell.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct DiaryCell: View {
    
    let data: DataModel
    
    @State var userName: String = "오스트랄로피테쿠스아파렌시스"
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color.fromString(data.color))
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(data.emoji)
                            Spacer()
                        }
                        .padding(.top, 8)
                        Text("\(data.content)")
                            .lineLimit(4)
                            .foregroundColor(Colors.Black1.color)
                        Spacer()
                        HStack {
                            Spacer()
                            Text("\(userName)")
                                .font(.system(size: 8))
                                .frame(width: 42, height: 10)
                                .foregroundColor(Colors.Blue5.color)
                        }
                    }
                    .frame(width: 140, height: 140)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 7)
                }
        }
    }
}
