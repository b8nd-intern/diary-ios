//
//  MyPageViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation





class MyPageViewModel: ObservableObject {
//    @Published var Yeardate : [Bool] = []
    @Published var postCounts: [Int] = [0]
    @Published var numbers: [Int] = [0]
    @Published var number: Int = 0
    
    func postYearCnt(callback: @escaping () -> Void) {
        let params = ["year": 2023 ]
        Task{
            do {
                let response  = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method:.get ,params: params , model: PostCntResponse.self))
                print(response.data)
                
                postCounts = response.data
                numbers = response.data
                
                number = numbers.reduce(0, { $0 + $1 })
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
//    func RecordYear(callback: @escaping () -> Void) {
//        Task{
//            do {
//                let response  = try await HttpClient.request(HttpRequest(url: "record/records/year", method:.get, model: RecordResponse<YearResponse>.self))
//               
//                
//                Yeardate = response.data.map { $0.isDone }
//                print("Yeardate:", Yeardate) // 로그 추가
//             
//                
//            } catch APIError.responseError(let statusCode) {
//                print("myPageViewModel - statusCode: ", statusCode)
//                
//            } 
//            catch APIError.transportError {
//                callback()
//                
//            }
//        }
//    }
}



