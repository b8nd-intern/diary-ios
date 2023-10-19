//
//  ToolbarView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        Text("Daily")
            .font(.system(size: 18))
            .bold()
        
        Spacer()
        
        NavigationLink {
            // 설정
        } label: {
            Image(systemName: "gearshape")
                .font(.system(size: 18))
                .foregroundColor(Colors.Black1.color)
        }
        
        NavigationLink {
            // 프로필
        } label: {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 18))
                .foregroundColor(Colors.Black1.color)
        }
    }
}
