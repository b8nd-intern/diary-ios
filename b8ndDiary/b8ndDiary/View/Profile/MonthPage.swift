//
//  MonthPage.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/06.
//
import SwiftUI
import GoogleSignIn
import Network
//class MyMonthPost: ObservableObject {
////    @Published var dataModels: [DataModel] = [] // 관찰 가능한 속성 추가
//    
//    static func getMonthPost() async throws -> [DataModel] {
//    
//        let params = ["year": 2023,"month": 1 ]
//        
//        let response = try await HttpClient.request(HttpRequest(url: "post/month", method: .get, params :params, model: Response<[DataModel]>.self))
//        
//        return response.data ?? [] // response.data가 nil이면 빈 배열 반환
//    }
//}
class MonthPost: ObservableObject {
    @Published var dataModels: [DataModel] = []

    static func postMonth(month: Int) async throws -> Response<[DataModel]> { // month 매개변수 추가
        let year = 2023
        let response = try await HttpClient.request(HttpRequest(url: "post/month/\(year)/\(month)", method: .get, model: Response<[DataModel]>.self))
        
        print(response)
        
        return response
    }
}


struct MonthPage: View {
    var selectedMonth: Int
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var myMonthPost = MonthPost()
    
    var body: some View {
        VStack {
            Text("\(selectedMonth)")
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
                }
        )
        .onAppear {
            Task {
                do {
                    let response = try await MonthPost.postMonth(month: selectedMonth) // selectedMonth 값을 전달
                    DispatchQueue.main.async {
                        myMonthPost.dataModels = response.data ?? []
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}
