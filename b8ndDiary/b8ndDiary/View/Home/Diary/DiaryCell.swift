//
//  DiaryCell.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct DiaryCell: View {
    
    @State var data: String = ""
    
    @State var userName: String = "오스트랄로피테쿠스아파렌시스"
    
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
//                        Text("\(userName)")
//                            .font(.system(size: 8))
//                            .frame(width: 20, height: 10)
                    }
                    .frame(width: 140, height: 140)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 7)
                }
        }
    }
}
