import SwiftUI
import Network

struct MonthPage: View {
    @State private var isDoing = true
    //    @Binding var userId : String
    @State private var refreshView = false
    var selectedMonth: Int
    @State var isClicked: Bool = false
    @State var clickedContent: DataModel?
    @State var diaryContent: String = "오늘은 개발을 했다."
    @State var day: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @StateObject var myMonthPost = MonthPostViewModel()
    //    let userData: UserData
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
    private var scrollObservableView: some View {
        GeometryReader { proxy in
            let offsetY = proxy.frame(in: .global).origin.y
            Color.clear
                .preference(
                    key: ScrollOffsetKey.self,
                    value: offsetY
                )
                .onAppear {
                    myMonthPost.setOriginOffset(offsetY)
                }
        }
        .frame(height: 0)
    }
    var body: some View {
        ZStack {
            ScrollView(showsIndicators : false){ // 추가
                //            ScrollView(showsIndicators : false){ // 추가
                VStack {
                    //                ScrollView{ // 추가
                    //                    VStack{//추가
                    
                    Text("\(selectedMonth)월")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .bold()
                        .padding(.top, 20)
                        .padding(.trailing, 240)
                    Button {
                        Task {
                            do {
                                let response = try await myMonthPost.postMonth(month: selectedMonth)
                                if let postIds = myMonthPost.extractPostIds(from: response) {
                                    print("Post IDs: \(postIds)")
                                    myMonthPost.postIds = postIds
                                }
                                myMonthPost.Postdelete(callback: {
                                    refreshView.toggle()
                                })
                            } catch {
                                print("Error: \(error)")
                            }
                        }
                    } label: {
                        Text("전체삭제")
                            .foregroundColor(.black)
                            .frame(width: 70,height: 70)
                            .opacity(0.5)
                            .font(.system(size: 15))
                            .padding(.top, 15)
                            .padding(.leading, 240)
                    }
                    ZStack{
                        //이미지 불러오는 부분
                        ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, day: $day, diaryContent: myMonthPost.dataModels)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 20)
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        myMonthPost.setOffset($0)
                    }
                    Spacer()
                    
                }
                .id(refreshView)
                .navigationBarBackButtonHidden()
                .navigationBarItems(
                    leading:
                        HStack(spacing: 16) {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                            })
                        }
                )
                .onAppear {
                    Task {
                        do {
                            let response = try await myMonthPost.postMonth(month: selectedMonth)
                            DispatchQueue.main.async {
                                myMonthPost.dataModels = response.data ?? []
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
                
                
            }
            
            if isClicked {
                
                ZStack{
                    //                                ScrollView{
                    Button {
                        isClicked = false
                    } label: {
                        ZStack{
                            GeometryReader { proxy in
                                Rectangle()
                                    .frame(width: proxy.size.width, height: proxy.size.height)
                                    .foregroundColor(Colors.Gray2.color)
                                    .opacity(0.5)
                            }
                        }
                    }
                    //                                }
                    
                    
                    // 실제 팝업 내용
                    VStack {
                        Spacer()
                        
                        ClickCell(data: clickedContent)
                            .frame(width: 327, height: 319)
                            .overlay {
                                VStack {
                                    HStack {
                                        NavigationLink(
                                            destination: PostView(isDoing: $isDoing, PostNum: clickedContent?.postId),
                                            label: {
                                                Text("수정")
                                                    .font(.system(size: 12))
                                                    .frame(width: 30, height: 26)
                                                    .foregroundColor(Colors.Blue5.color)
                                                    .padding(.leading, 220)
                                                    .padding(.top, 20)
                                            }
                                        )
                                        
                                        Button(action: {
                                            Task {
                                                do {
                                                    myMonthPost.postIds = [clickedContent!.postId]
                                                    myMonthPost.Postdelete(callback: {
                                                        refreshView.toggle()
                                                    })
                                                } catch {
                                                    print("Error: \(error)")
                                                }
                                            }
                                        }, label: {
                                            Text("삭제")
                                                .font(.system(size: 12))
                                                .frame(width: 30, height: 26)
                                                .foregroundColor(Colors.Blue5.color)
                                                .padding(.top, 20)
                                        })
                                    }
                                    Spacer()
                                }
                            }
                        
                        Spacer()
                        Spacer()
                    }
                }
//                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}
//    }// 추가

