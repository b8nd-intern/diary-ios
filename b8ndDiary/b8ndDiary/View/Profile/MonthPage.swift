import SwiftUI
import Network

struct MonthPage: View {
    //    @Binding var userId : String
    var selectedMonth: Int
    @State var isClicked: Bool = false
    @State var clickedContent: DataModel?
    @State var diaryContent: String = "오늘은 개발을 했다."
    @State var day: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @StateObject var myMonthPost = MonthPost()
//    let userData: UserData
    
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
        VStack {
            Text("\(selectedMonth)월")
                .foregroundColor(.black)
                .font(.system(size: 30))
                .bold()
                .padding(.top, 20)
                .padding(.trailing, 240)
            
            
//            Button{
//                Task {
//                    do {
//                        let response = try await MonthPost.postMonth(month: selectedMonth)
//                        if let postIds = MonthPost.extractPostIds(from: response) {
//                            print("Post IDs: \(postIds)")
//                            myMonthPost.postIds = postIds
//
//                        }
//                    } catch {
//                        print(error)
//                    }
//                }
//            }label: {
//                Text("전체삭제")
//                    .foregroundColor(.black)
//                    .opacity(0.5)
//                    .font(.system(size: 15))
//                    .padding(.top, 15)
//                    .padding(.leading, 240)
//            }

            Button {
                print("버튼 눌러짐")
                Task {
                    do {
                        let response = try await MonthPost.postMonth(month: selectedMonth)
                        if let postIds = MonthPost.extractPostIds(from: response) {
                            print("Post IDs: \(postIds)")
                            myMonthPost.postIds = postIds
                        }
                        myMonthPost.Postdelete(callback: {
                            
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
            .contentShape(Rectangle())
           


            
            ZStack{
                //이미지 불러오는 부분
                ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, day: $day, diaryContent: myMonthPost.dataModels)
                    .padding(.horizontal, 30)
            }
            .padding(.top, 20)
            .onPreferenceChange(ScrollOffsetKey.self) {
                myMonthPost.setOffset($0)
            }
            
//            if isClicked && (clickedContent != nil) {
//                ClickDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, userData: userData)
//            }
         
            Spacer()
        }
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
                    let response = try await MonthPost.postMonth(month: selectedMonth)
                    DispatchQueue.main.async {
                                           myMonthPost.dataModels = response.data ?? []
                                       }
                } catch {
                    print(error)
                }
            }
        }

        }



    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
}
