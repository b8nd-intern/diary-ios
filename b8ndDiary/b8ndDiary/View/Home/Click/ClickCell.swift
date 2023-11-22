//
//  ClickCell.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ClickCell: View {
    
    @State var data: DataModel?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .foregroundColor(Color.fromString(data?.color ?? ""))
            .overlay {
                VStack {
                    HStack {
                        Image(data?.emoji ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding(.leading, 16)
                        Spacer()
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    Text(data?.content ?? "")
                        .font(.custom("Pretendard-Medium", size: 16))
                        .foregroundColor(Colors.Black1.color)
                        .frame(width: 250)
                    
                    Spacer()
                }
            }
    }
}
