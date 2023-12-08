import SwiftUI
import Network

struct UserMonthPage: View {
    @Binding var userId : String // 추가
    var selectedMonth: Int
    @State var isClicked: Bool = false
    @State var clickedContent: DataModel?
    @State var diaryContent: String = "오늘은 개발을 했다."
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var myMonthPost = MonthPostViewModel()
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
       
            GeometryReader { geo in
                VStack {
                    scrollObservableView
                    
                    Text("\(selectedMonth)월")
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .bold()
                        .padding(.top, 20)
                        .padding(.trailing, 240)
                    
                    
                    ScrollView{
                    ZStack{
                        //이미지 불러오는 부분
                        ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, diaryContent: myMonthPost.dataModels)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 20)
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        myMonthPost.setOffset($0)
                    }
                    
                    //                if isClicked && (clickedContent != nil) {
                    //                    ClickDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, userData: userData)
                    //
                    //
                    //                }
                    
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
                            let userId = userId
                            let postResponse = try await myMonthPost.userpostMonth(month: selectedMonth, userId: userId)
                            DispatchQueue.main.async {
                                myMonthPost.dataModels = postResponse.data ?? []
                            }
                        } catch {
                            print("Error: \(error)")
                        }
                        
                    }
                }
                .background(scrollObservableView)
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
