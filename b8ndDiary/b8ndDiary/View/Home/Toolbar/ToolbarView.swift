//
//  ToolbarView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ToolbarView: View {
    
    let userData: UserData
    
    var body: some View {
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
}
