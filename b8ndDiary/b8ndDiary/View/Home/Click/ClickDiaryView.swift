//
//  ClickDiaryView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ClickDiaryView: View {
    
    @Binding var isClicked: Bool
    @Binding var clickedContent: String
    
    var body: some View {
        ZStack {
            
            Button {
                isClicked = false
            } label: {
                ZStack {
                    GeometryReader { proxy in
                        Rectangle()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .foregroundColor(Colors.Gray2.color)
                            .opacity(0.5)
                    }
                }
            }
            
            VStack {
                Spacer()
                ClickCell(data: clickedContent)
                    .frame(width: 327, height: 319)
                    .overlay {
                        VStack {
                            HStack {
                                Button {
                                    
                                } label: {
                                    Text("수정")
                                        .foregroundColor(Colors.Gray3.color)
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("삭제")
                                        .foregroundColor(Colors.Gray3.color)
                                }
                            }
                            .padding(.leading, 220)
                            .padding(.top, 30)
                            Spacer()
                        }
                    }
                Spacer()
                Spacer()
            }
            
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}
