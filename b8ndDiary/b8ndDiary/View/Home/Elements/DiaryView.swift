//
//  OnbardingCardView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 06.09.2022.
//

import SwiftUI

struct DiaryView: View {
    
    let card: DiaryModel
    let width: CGFloat
    let height: CGFloat
    let imojiOpacity: CGFloat
    let boardTextOpacity: CGFloat
    
    @State var userName: String = "오스트랄로피테쿠스아파렌시스"

    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Image(card.image)
                        .resizable()
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(x: 12, y: -10)
                        .opacity(imojiOpacity)
                    Spacer()
                }
                Spacer()
            }
            .zIndex(1)
            
            ZStack {
                Text(card.text)
                    .padding()
                    .foregroundColor(.black)
                    .font(.body)
                    .frame(width: width, height: height, alignment: .leading)
                    .lineLimit(6)
                
                Text("\(userName)")
                    .lineLimit(1)
                    .frame(width: 70)
                    .foregroundColor(Colors.Blue5.color)
                    .font(.system(size: 12))
                    .font(.body)
                    .padding(.top, 180)
                    .padding(.leading, 130)
            }
            .opacity(boardTextOpacity)
            .background(card.color)
            .cornerRadius(5)
        }
        .frame(width: width, height: height)
    }
}
