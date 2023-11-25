//
//  MonthPage.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/06.
//
import SwiftUI
import Network

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct MonthPage: View {
    struct ScrollOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = .zero
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
    
    var selectedMonth: Int
    @State var isClicked: Bool = false
    @State var clickedContent: DataModel?
    @State var diaryContent: String = "오늘은 개발을 했다."
    @State var day: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var myMonthPost = MonthPost()
    
    var body: some View {
        let scrollObservableView: some View = {
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
        }()
        
        VStack {
            Text("\(selectedMonth)월")
                .foregroundColor(.black)
                .font(.system(size: 30))
                .bold()
                .padding(.top, 20)
                .padding(.trailing, 240)
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
                    Spacer()
                    ZStack{
                        //이미지 불러오는 부분
                        ShowDiaryView(isClicked: $isClicked, clickedContent: $clickedContent, day: $day, diaryContent: myMonthPost.dataModels)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 30)
                    .onPreferenceChange(ScrollOffsetKey.self) {
                        myMonthPost.setOffset($0)
                    }
                }
        )
        .onAppear {
            Task {
                do {
                    let response = try await MonthPost.postMonth(month: selectedMonth) // selectedMonth 값을 전달
                    DispatchQueue.main.async {
                        myMonthPost.dataModels = response.data ?? []
                        myMonthPost.setOffset(myMonthPost.offset)
                    }
                } catch {
                    print(error)
                }
            }
        }
        .background(scrollObservableView)
    }
}
