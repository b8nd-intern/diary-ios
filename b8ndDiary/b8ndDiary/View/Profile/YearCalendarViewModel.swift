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

class YearCalendarViewModel: ObservableObject {
    @Published var Yeardate: [Bool] = []
    
    func RecordYear(callback: @escaping () -> Void) {
        Task {
            do {
                let response = try await HttpClient.request(HttpRequest(url: "record/records/year", method:.get, model: RecordResponse<YearResponse>.self))
                
                Yeardate = response.data.map { $0.isDone }
                Yeardate[3] = true
                print("갯수", Yeardate.count)
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
                
            } catch APIError.transportError {
                callback()
                
            }
        }
    }
}
