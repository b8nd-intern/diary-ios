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
    
    let userData: UserData
    
    var body: some View {
        VStack {
            HStack {
                if isTextAnimation {
                    
                        VStack(alignment: .leading) {
                            HStack {
                                Text("오늘의 글")
                                    .font(.system(size: 18))
                                    .bold()
                                
                                Spacer()
                                
                                toolbarProfileSetting(userData: userData)
                            }
                            
                            Text("2023년 10월 31일")
                                .font(.system(size: 12))
                                .foregroundStyle(Colors.Gray2.color)
                                .offset(y: isTextAnimation ? 0 : -100)
                            
                        }
                        .padding(.bottom, 5)

                } else {
                    
                    HStack {
                        
                        Text("하루일기")
                            .font(.system(size: 18))
                            .bold()
                        
                        Spacer()
                        
                        toolbarProfileSetting(userData: userData)
                    }
                    .padding(.bottom, 5)
                    
                }
                
            }
            
        }
        .onChange(of: scrolling) { i in
            
            withAnimation(.easeInOut(duration: 0.5)) {
                if i < -353 {
                    isTextAnimation = true
                } else {
                    isTextAnimation = false
                }
            }
        }
    }
}

struct toolbarProfileSetting: View {
    
    let userData: UserData
    
    var body: some View {
        HStack {
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
    }
}
