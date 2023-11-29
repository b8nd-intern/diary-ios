//
//  YearCalendarViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/22/23.
//

//
//  MyPageViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation
import Combine

class YearCalendarViewModel: ObservableObject {
    // 이거 안됨 userid myuserid
//    var userId = MyPageViewModel.shared.userId
    var myuserId = MyPageViewModel.shared.myuserId
    @Published var userId: String = ""
   
    @Published var Yeardate: [Bool] = []
    
    func RecordYear(callback: @escaping () -> Void) {
        let param = ["userId": userId.isEmpty ? myuserId : userId] as [String: Any]
        Task {
            do {                
                
                print("잔디 유저 아이디 이동 확인 : \(userId)")
                let response = try await HttpClient.request(HttpRequest(url: "record/records/year", method:.get, params : param ,model: RecordResponse<YearResponse>.self))
                
                Yeardate = response.data.map { $0.isDone }
                Yeardate = Array(Yeardate[35..<365])

                print(response)
                print("갯수", Yeardate.count)
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
                
            } catch APIError.transportError {
                callback()
                
            }
        }
    }
}
