//
//  MyPageViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation


struct RecordResponse <T: Codable> : Codable {
    let status: Int
    let message: String
    let data: [T?]
}

struct WeekResponse : Codable {
    let date : String
    let isDone : Bool
    
}

class MyPageViewModel: ObservableObject {
    
    @Published var postCounts: [Int] = [0]
    @Published var numbers: [Int] = [0]
    @Published var number: Int = 100
    func postYearCnt(callback: @escaping () -> Void) {
        let params = ["year": 2023 ]
        Task{
            do {
                let response  = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method:.get ,params: params , model: PostCntResponse.self))
                print(response.data)
                
                postCounts = response.data
                numbers = response.data
        
                number = numbers.reduce(0, { $0 + $1 })
   
                
//                numbers.reduce(0) { (a: Int, b: Int) -> Int in
//                    return a + b
//                }
//                
//          
//                number = numbers[0]
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    func RecordWeek(callback: @escaping () -> Void) {

        Task{
            do {
                let response  = try await HttpClient.request(HttpRequest(url: "/record/records/week", method:.get, model: RecordResponse<WeekResponse>.self))
                print(response)
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
                
            } catch {
                
                print("Record Week 오류: \(error)")
                
            }
            catch APIError.transportError {
                callback()
                
            }
        }
    }
}



