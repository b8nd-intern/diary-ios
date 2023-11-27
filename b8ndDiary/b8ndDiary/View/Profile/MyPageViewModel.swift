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
    
//    func Postdelete(callback: @escaping () -> Void) {
//        let body = ["postId": DataModel.postId]
//        Task{
//            do {
//                let response  = try await HttpClient.request(HttpRequest(url: "post/delete", method:.delete ,params: body, model:
//                        Response<PostdeleteResponse>.self))
//                print(response.data)
//                
//                
//            } catch APIError.responseError(let statusCode) {
//                print("myPageViewModel - statusCode: ", statusCode)
//            } catch APIError.transportError {
//                callback()
//            }
//        }
//    }
    
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
    
}



