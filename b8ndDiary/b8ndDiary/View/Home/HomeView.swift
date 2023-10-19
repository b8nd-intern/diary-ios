//
//  HomeView.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    // 일기를 클릭해서 볼 때 사용되는 변수
    @State var isClicked: Bool = false
    @State var clickedContent: String = ""
    
    // 일기 내용 가져올 때 사용되는 변수
    @State var day: Int = 0
    
    @State var diaryContent: String = "오늘은 개발을 했다." // 가로 스크롤 뷰 일기 내용
    @State var name: String = "이예진" // 사용자 이름
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack { // 툴바
                        ToolbarView()
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            HStack {
                                Text("오늘 하루의\n기록을 쌓아보세요!")
                                    .font(.system(size: 20))
                                    .padding(.leading, 30)
                                Spacer()
                            }
                            .padding(.top, 5)

                            // 가로 스크롤뷰
                            HScrollView(diaryContent: $diaryContent)
                            
                            Spacer()
                                .frame(height: 57)
                            
                            HStack {
                                Text("\(name)")
                                    .font(.system(size: 16))
                                    .bold()
                                Text("님의 출석 진행상황")
                                    .font(.system(size: 14))
                            }
                            .padding(.trailing, 110)
                            HStack {
                                DayView(day: $day)
                            }
                            
                            Divider()
                                .padding(.horizontal, 50)
                            
                            Spacer()
                                .frame(height: 53)
                            
                            // 일기 띄우기
                            ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, day: $day)
                                .padding(.horizontal, 40)
                            
                        }
                    }
                }
                
                // 일기 작성 뷰로 넘어가는 코드
                NavigationLink {
                    PostView()
                } label: {
                    PostButtonView()
                }
                .padding(.leading, 220)
                .padding(.top, 520)
                
                // 포스트잇을 클릭하면 일기를 보여주는 코드
                if isClicked {
                    ClickDiaryView(isClicked: $isClicked, clickedContent: $clickedContent)
                }
            }
        }
    }
}

