//
//  HomeView.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    @StateObject private var dayViewModel: DayViewModel = DayViewModel()
    
    // 일기를 클릭해서 볼 때 사용
    @State var isClicked: Bool = false
    @State var clickedContent: DataModel?
    
    let userData: UserData
    
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
    var body: some View {
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
                                        if viewModel.topSevenList.count == 7 {
                                            PrettyHScrollView(_activePageIndex: viewModel.topSevenList.count - 3, cards: viewModel.topSevenList, geo: geo)
                                        }
                                    }
                                    .padding(.bottom, 30)
                                    
                                    HStack {
                                        Text("\(userData.name)")
                                            .font(.system(size: 16))
                                            .bold()
                                        Text("님의 출석 진행상황")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.trailing, 110)
                                    .padding(.bottom, 5)
                                    
                                    HStack {
                                        if !dayViewModel.dayList.isEmpty {
                                            ForEach(0..<7, id: \.self) { i in
                                                DayView(dayViewModel: dayViewModel, dayState: dayViewModel.dayList[i].isDone, i: i)
                                            }
                                        }
                                    }
                                    
                                    Divider()
                                        .padding(.horizontal, 50)
                                    
                                    Spacer()
                                        .frame(height: 40)
                                
                                    ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, diaryContent: viewModel.diaryList)
                                        .padding(.horizontal, 40)
                                    
                                }
                            }
                            .padding(.top, 30)
                            .onPreferenceChange(ScrollOffsetKey.self) {
                                viewModel.setOffset($0)
                            }
                        }
                    }
                    
                    VStack {
                        ToolbarView(scrolling: $viewModel.offset, userData: userData)
                            .padding(.horizontal, 20)
                            .padding(.top, 60)
                            .background(.white)
                            .ignoresSafeArea(.all)
                        
                        Spacer()
                    }
                    
                    // 일기 작성 뷰로 넘어가는 코드
                    HStack {
                        Spacer()
                        VStack {
                            Spacer()
                            NavigationLink {
                                PostView(isDoing: .constant(false), PostNum: 0)
                            } label: {
                                PostButtonView()
                            }
                            .padding(.trailing, 35)
                            .padding(.bottom, 90)
                        }
                    }
                    
                    // 포스트잇을 클릭 시 보여줄 일기
                    if isClicked && clickedContent != nil {
                        ClickDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, userData: userData)
                    }
                }
            }
        }
        .task {
            await viewModel.initDiaryList {
                appViewModel.save(false)
            }
            await viewModel.initTopSevenList {
                appViewModel.save(false)
            }
            await dayViewModel.initDiaryList()
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
