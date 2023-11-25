//
//  HomeView.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @EnvironmentObject var appViewModel: AppViewModel
    
    @State var isTextAnimation = false
    
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear {
                    viewModel.setOriginOffset(offsetY)
                }
        }
        .frame(height: 0)
    }
    
    // 일기를 클릭해서 볼 때 사용되는 변수
    @State var isClicked: Bool = false
    @State var clickedContent: DataModel?
    
    let userData: UserData
    
    // 일기 내용 가져올 때 사용되는 변수
    @State var day: Int = 0
    
    @State var name: String = "이예진" // 사용자 이름
    
    var body: some View {
        
        @State var offset: CGFloat = viewModel.offset
        
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    VStack {
                        ScrollViewReader { proxy in
                            ScrollView(showsIndicators: false) {
                                VStack {
                                    scrollObservableView
                                    HStack {
                                        Text("오늘 하루의\n기록을 쌓아보세요!")
                                            .font(.system(size: 20))
                                            .padding(.leading, 30)
                                        Spacer()
                                    }
                                    .padding(.top, 5)
                                    
                                    ZStack {
                                        Image("DottedBackground")
                                            .resizable()
                                            .frame(width: geo.size.width, height: 220)
                                            .padding(.top, 40)
                                        if viewModel.topList.count > 0 {
                                            PrettyHScrollView(_activePageIndex: viewModel.topList.count - 3, cards: viewModel.topList, geo: geo)
                                        }
                                        
                                    }
                                    .padding(.bottom, 30)
                                    
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
                                        .frame(height: 40)
                                    
                                    ZStack {
                                        ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, day: $day, diaryContent: viewModel.list)
                                            .padding(.horizontal, 40)
                                    }
                                    
                                }
                            }
                            .padding(.top, 30)
                            .onPreferenceChange(ScrollOffsetKey.self) {
                                viewModel.setOffset($0)
                            }
                        }
                    }
                    
                    VStack {
                        HStack { // 툴바
                            ToolbarView(scrolling: $viewModel.offset, userData: userData)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 60)
                        .background(.white)
                        .ignoresSafeArea(.all)
                        
                        Spacer()
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
                    if isClicked && (clickedContent != nil) {
                        ClickDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, userData: userData)
                    }
                }
            }
        }
        .onAppear {
            viewModel.initDiaryList {
                appViewModel.save(false)
            }
            viewModel.initTopSevenList {
                appViewModel.save(false)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
}

