//
//  PostView.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/10/04.
//

import SwiftUI

struct PostView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var text: String = ""
    @State var publicState: Bool = true
    @State var backgroundColor: Color = Colors.Blue1.color
    
    var backgroundColorList: [Color] = [Colors.Black1.color, Colors.Blue1.color, Colors.Blue2.color, Colors.Blue3.color]
    var placeholder: String = "오늘 즐거웠던 활동은 무엇인가요?"
    
    var body: some View {
        NavigationView {
            VStack {
                // 공개 비공개
                HStack {
                    // 공개
                    Button {
                        // 공개로 설정되는 코드
                        
                        publicState = true
                    } label: {
                        if publicState {
                            Text("공개")
                                .foregroundColor(Colors.Gray2.color)
                                .font(.system(size: 16))
                                .bold()
                        } else {
                            Text("공개")
                                .foregroundColor(Colors.Gray3.color)
                                .font(.system(size: 16))
                        }
                    }
                    // 비공개
                    Button {
                        // 비공개로 설정되는 코드
                        
                        publicState = false
                    } label: {
                        if publicState {
                            Text("비공개")
                                .foregroundColor(Colors.Gray3.color)
                                .font(.system(size: 16))
                        } else {
                            Text("비공개")
                                .foregroundColor(Colors.Gray2.color)
                                .font(.system(size: 16))
                                .bold()
                        }
                    }
                    
                    Spacer()
                }
                .padding(.leading, 40)
                
                // 일기 미리보기
                Rectangle()
                    .foregroundColor(backgroundColor)
                    .frame(width: 300, height: 300)
                    .padding(.bottom, 24)
                    .overlay {
                        VStack {
                            Text("\(text)")
                            Spacer()
                        }
                        .frame(width: 250, height: 250)
                    }
                
                // 일기 작성
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.white)
                    
                    VStack {
                        HStack { // 미리보기 포스트잇 색 설정
                            let colorList: [Color] = [Colors.Black1.color, Colors.Blue1.color, Colors.Blue2.color, Colors.Blue3.color]
                            ForEach(colorList, id: \.self) { color in
                                Button {
                                    backgroundColor = color
                                } label: {
                                    RoundedRectangle(cornerRadius: 16)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(color)
                                }
                            }
                            Spacer()
                            Button {
                                dismiss()
                            } label: {
                                ZStack { // 일기 올리기
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 65, height: 33)
                                        .foregroundColor(Colors.Blue2.color)
                                    Text("올리기")
                                        .foregroundColor(Colors.Black1.color)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Divider()
                        
                        // 텍스트 에디터
                        ZStack(alignment: .topLeading) {
                            TextEditor(text: $text)
                                .cornerRadius(20)
                            if text.isEmpty {
                                Text("\(placeholder)")
                                    .foregroundColor(.gray)
                                    .padding(.top, 8)
                                    .padding(.leading, 5)
                            }
                        }
                    }
                    .padding(.top, 15)
                }
                .padding(.horizontal, 10)
                .edgesIgnoringSafeArea(.all)
                
            }
            .background(Colors.Gray2.color)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        // 일기 내용 저장?
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .frame(width: 22, height: 22)
                            .foregroundColor(Colors.Black1.color)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
