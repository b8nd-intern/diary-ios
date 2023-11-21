//
//  HomeView.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 2023/10/04.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
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
    @State var clickedContent: String = ""
    
    let userData: UserData
    
    // 일기 내용 가져올 때 사용되는 변수
    @State var day: Int = 0
    
    @State var diaryContent: String = "오늘은 개발을 했다." // 가로 스크롤 뷰 일기 내용
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
                                        
                                        PrettyHScrollView(cards: [
                                            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "Image"),
                                            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Yellow1.color, image: "Image"),
                                            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue1.color, image: "Image"),
                                            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Blue2.color, image: "Image"),
                                            DiaryModel(id: UUID(), text: "오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 기쁘다. 항상 열심히 아이디어 내주는 모습이 멋지고 더 노력 하게 만들어주어 고맙다! ...", color: Colors.Yellow1.color, image: "Image")
                                        ], geo: geo)
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
                                        // 일기 띄우기
//                                        ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, day: $day, diaryContent: ["오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 행복했다. 그리고 나중에", "개발을 했다1", "개발을 했다2", "개발을 했다3", "개발을 했다4", "개발을 했다5", "개발을 했다6", "개발을 했다7", "개발을 했다8", "개발을 했다9", "개발을 했다10", "개발을 했다11", "개발을 했다12", "개발을 했다13", "개발을 했다14", "개발을 했다15", "개발을 했다16", "개발을 했다17", "개발을 했다18", "개발을 했다19", "개발을 했다20", "개발을 했다21", "개발을 했다22", "개발을 했다23", "개발을 했다24", "개발을 했다25", "개발을 했다26", "개발을 했다27", "개발을 했다28", "개발을 했다29", "개발을 했다30", "개발을 했다31", "개발을 했다32", "개발을 했다33", "개발을 했다34", "개발을 했다35", "개발을 했다36", "개발을 했다37", "개발을 했다38", "개발을 했다39", "개발을 했다40", "개발을 했다41", "개발을 했다42", "개발을 했다43", "개발을 했다44", "개발을 했다45", "개발을 했다46", "개발을 했다47", "개발을 했다48", "개발을 했다49", "개발을 했다50", "개발을 했다51", "개발을 했다52", "개발을 했다53", "개발을 했다54", "개발을 했다55", "개발을 했다56", "개발을 했다57", "개발을 했다58", "개발을 했다59", "개발을 했다60", "개발을 했다61", "개발을 했다62", "개발을 했다63", "개발을 했다64", "개발을 했다65", "개발을 했다66", "개발을 했다67", "개발을 했다68", "개발을 했다69", "개발을 했다70", "개발을 했다71", "개발을 했다72", "개발을 했다73", "개발을 했다74", "개발을 했다75", "개발을 했다76", "개발을 했다77", "개발을 했다78", "개발을 했다79", "개발을 했다80", "개발을 했다81", "개발을 했다82", "개발을 했다83", "개발을 했다84", "개발을 했다85", "개발을 했다86", "개발을 했다87", "개발을 했다88", "개발을 했다89", "개발을 했다90", "개발을 했다91", "개발을 했다92", "개발을 했다93", "개발을 했다94", "개발을 했다95", "개발을 했다96", "개발을 했다97", "개발을 했다98", "개발을 했다99", "개발을 했다 100"])
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
                    if isClicked {
                        ClickDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, userData: userData)
                    }
                }
            }
        }
        .onAppear {
            viewModel.initDiaryList()
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
