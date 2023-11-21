//
//  MyPageViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation


class MyPageViewModel: ObservableObject {
    
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
                
                numbers.reduce(0) { (a: Int, b: Int) -> Int in
                    return a + b
                }
                number = numbers[0]
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
}



