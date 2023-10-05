//
//  Login.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 2023/10/04.
//

import SwiftUI
import AuthenticationServices

struct Login: View {
    
    var body: some View {
        
        VStack {
            ZStack{
                Image("dot")
                    .resizable()
                    .frame(maxWidth:.infinity , maxHeight: 210)
                    .ignoresSafeArea()
            }
            .padding(.bottom,10)
            
            VStack { // 하루일기 이미지

                Image("icon")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.bottom, 15)
                
                Text("하루일기")
                    .foregroundColor(.black)
                    .font(.system(size: 30, design: .rounded))
                    .bold()
                    .padding(.bottom, 8)
                
                Text("내 삶을 잠시나마\n돌아보는 짧은 순간들")
                    .foregroundColor(.black)
                    .font(.system(size: 17, design: .rounded))
                    .multilineTextAlignment(.center)
                    .opacity(0.5)
                    .padding(.bottom,60)
//                ContentView(userData: UserData(url: nil, name: "", email: ""))
//                Spacer()
            } // 하루일기 이미지 끝
            
        }// 큰 vstack 끝
    }
}
