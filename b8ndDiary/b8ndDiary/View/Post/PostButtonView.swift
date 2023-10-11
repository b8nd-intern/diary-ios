//
//  PostButtonView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct PostButtonView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 28)
            .frame(width: 65, height: 65)
            .foregroundColor(.white)
            .overlay(
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Colors.Black1.color, lineWidth: 0.1)
                    Image("Pencil")
                        .font(.system(size: 36))
                }
            )
    }
}
