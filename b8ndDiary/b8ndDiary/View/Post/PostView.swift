//
//  PostView.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/10/04.
//

import SwiftUI

struct PostView: View {
    
    enum test: Hashable {
        case test
    }
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: PostViewModel = PostViewModel()
    @EnvironmentObject var info: Info
    
    @State var isTapEmojiButton: Bool = false
    @State private var isAlert = false
    
    @FocusState var isFocused: test?
    
    var emojiList: [String] = ["smile", "wacky", "woo", "stress", "angry"]
    var backgroundColorList: [Color] = [Colors.Blue1.color, Colors.Blue2.color, Colors.Blue3.color, Colors.Yellow1.color]
    var placeholder: String = "오늘 즐거웠던 활동은 무엇인가요?"
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                //            VStack {
                //
                //                HStack {
                //                    // 공 비
                //                }
                //
                //            }
                ZStack {
                    VStack {
                        // 공개 비공개
                        HStack {
                            // 공개
                            Button {
                                // 공개로 설정되는 코드
                                viewModel.publicState = true
                            } label: {
                                if viewModel.publicState {
                                    Text("공개")
                                        .foregroundColor(Colors.Blue5.color)
                                        .font(.system(size: 16))
                                        .bold()
                                } else {
                                    Text("공개")
                                        .foregroundColor(Colors.Gray2.color)
                                        .font(.system(size: 16))
                                }
                            }
                            // 비공개
                            Button {
                                // 비공개로 설정되는 코드
                                viewModel.publicState = false
                            } label: {
                                if viewModel.publicState {
                                    Text("비공개")
                                        .foregroundColor(Colors.Gray2.color)
                                        .font(.system(size: 16))
                                } else {
                                    Text("비공개")
                                        .foregroundColor(Colors.Blue5.color)
                                        .font(.system(size: 16))
                                        .bold()
                                }
                            }
                            Spacer()
                        }
                        .padding(.leading, 40)
                        
                        // 일기 미리보기
                        Rectangle()
                            .foregroundColor(viewModel.backgroundColor)
                            .frame(width: 300, height: 300)
                            .padding(.bottom, 20)
                            .overlay {
                                VStack {
                                    ZStack {
                                        HStack {
                                            Button {
                                                isTapEmojiButton = true
                                            } label: {
                                                Image(viewModel.selectedEmoji)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                            }
                                            Spacer()
                                        }
                                        
                                        if isTapEmojiButton {
                                            RoundedRectangle(cornerRadius: 16)
                                                .foregroundColor(.white)
                                                .frame(width: 240, height: 50)
                                                .overlay {
                                                    ZStack {
                                                        RoundedRectangle(cornerRadius: 16)
                                                            .stroke(Colors.Blue4.color, lineWidth: 1)
                                                            .frame(width: 240, height: 50)
                                                        HStack {
                                                            ForEach(emojiList, id: \.self) { emojiName in
                                                                Button {
                                                                    viewModel.selectedEmoji = emojiName
                                                                    isTapEmojiButton = false
                                                                } label: {
                                                                    Image(emojiName)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                .offset(x: 25, y: -30)
                                            
                                        }
                                        
                                    }
                                    
                                    TextEditor(text: $viewModel.text)
                                        .focused($isFocused, equals: .test)
                                        .scrollContentBackground(.hidden)
                                    
                                    Spacer()
                                }
                                .frame(width: 250, height: 250)
                                .padding(.bottom, 20)
                                
                            }
                        
                        Spacer()
                        
                        // 일기 작성
                        ZStack {
                            VStack {
                                ZStack {
                                    HStack {
                                        // 미리보기 포스트잇 색 설정
                                        ForEach(backgroundColorList, id: \.self) { color in
                                            Button {
                                                viewModel.backgroundColor = color
                                            } label: {
                                                RoundedRectangle(cornerRadius: 16)
                                                    .frame(width: 20, height: 20)
                                                    .foregroundColor(color)
                                            }
                                        }
                                        
                                        Spacer()
                                        
                                        Button {
                                            viewModel.post {
                                                dismiss()
                                            } error: {
                                                dismiss()
                                                info.isLogined = false
                                            } error2: {
                                                isAlert = true
                                            }

                                        } label: {
                                            Text("올리기")
                                                .foregroundColor(Colors.Blue4.color)
                                                .frame(width: 65, height: 33)
                                                .background(Colors.Blue1.color)
                                                .cornerRadius(20)
                                        }
                                    }
                                    .padding(.horizontal, 15)
                                    .padding(.bottom, 30)
                                    
                                }
                                .frame(height: 100)
                                .background(Color.white)
                                .cornerRadius(30, corners: [.topRight, .topLeft])
                                .ignoresSafeArea(.all)
                                .padding(.bottom, -30)
                                
                            }
                        }
                    }
                }
                .background(Colors.Gray1.color)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 22, height: 22)
                                .foregroundColor(Colors.Black1.color)
                        }
                    }
                }
                .onTapGesture {
                    isTapEmojiButton = false
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear {
                isFocused = .test
            }
            .alert(LocalizedStringKey("하루에 두 번만 작성이 가능해요!"), isPresented: $isAlert) {
                Button("확인") {
                    dismiss()
                }
            } message: {
                Text("작성 실패")
            }
        }
    }
}
