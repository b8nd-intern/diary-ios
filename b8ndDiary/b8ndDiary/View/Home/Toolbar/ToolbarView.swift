//
//  ToolbarView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ToolbarView: View {
    
    @State var isTextAnimation = false
    @Binding var scrolling: CGFloat
    
    @State var originScrolling: CGFloat = 0
    
    let userData: UserData
    
    var body: some View {
        VStack {
            HStack {
                Text("하루일기")
                    .font(.system(size: 18))
                    .bold()
                
                Spacer()
                
                NavigationLink {
                    MyPageView(userData: userData)
                } label: {
                    Image(systemName: "person.crop.circle")
                        .font(.system(size: 18))
                        .foregroundColor(Colors.Black1.color)
                }
                
                NavigationLink {
                    Setting()
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 18))
                        .foregroundColor(Colors.Black1.color)
                }
            }
            
            if isTextAnimation {
                HStack {
                    VStack(alignment: .leading) {
                        Text("오늘의 글")
                        Text("2023년 10월 31일")
                            .font(.system(size: 12))
                            .foregroundStyle(Colors.Gray2.color)
                    }
                    .padding(.top, 5)
                    .padding(.leading, 20)
                    .offset(y: isTextAnimation ? 0 : -100)
                    
                    Spacer()
                }
            }
            
        }
        .onChange(of: scrolling) { i in
            if isTextAnimation && scrolling > originScrolling {
                print("1")
            }
            
            originScrolling = scrolling
            
            withAnimation(.easeInOut(duration: 0.5)) {
                if i < 80 {
                    isTextAnimation = true
                } else {
                    isTextAnimation = false
                }
            }
        }
    }
}
