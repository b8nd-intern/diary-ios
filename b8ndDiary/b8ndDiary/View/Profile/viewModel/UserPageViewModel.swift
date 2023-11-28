//
//  MyPageViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation
import Alamofire

class UserPageViewModel: ObservableObject {
    
//    let postId = MonthPost.shared.postId
    //다른 뷰에서 바인딩을 받은 userId값을 가지고 있는 userpageview 에서 받아온 userId
//    var userId: String = ""
//    var myuserId : String = ""
//    static let shared = MyPageViewModel()
    @Published var userId: String = ""
    @Published var myuserId: String = ""
    static let shared = UserPageViewModel()
    
    //    @Published var Yeardate : [Bool] = []
    @Published var postCounts: [Int] = [0]
    @Published var numbers: [Int] = [0]
    @Published var number: Int = 0
    
    @Published var username: String = ""
    @Published var userimages: URL? = URL(string: "")
    

    
    func postYearCnt(callback: @escaping () -> Void) {
        let params = ["year": 2023, "userId": userId] as [String: Any]
        
        
        Task {
            do {
                let response = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method: .get, params: params, model: PostCntResponse.self))
                print("포스트 갯수 : \(response.data)")
                
                postCounts = response.data
                numbers = response.data
                
                number = numbers.reduce(0, { $0 + $1 })
            } catch APIError.responseError(let statusCode) {
                print("PostcntViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
   
    func Uesrinfo(callback: @escaping () -> Void) {
        let param = ["userId": userId ]
        Task{
            do {
                
                let Userresponse  = try await HttpClient.request(HttpRequest(url: "user/info", method:.get,params: param , model: UserInfoResponse<UserInfo>.self))
                print(Userresponse.data)
                username = Userresponse.data.name
                if let imageUrl = URL(string: Userresponse.data.images) {
                    userimages = imageUrl
                } else {
                    userimages = nil
                }
                
                
                print("이름 : \(username)")
                print("이미지 : \(String(describing: userimages))")
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }


    
    
    //    func UserpostYearCnt(callback: @escaping () -> Void) {
    //        let params = ["year": 2023 ,"userId": userId] as [String : Any]
    //        Task{
    //            do {
    //                let response  = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method:.get ,params: params , model: PostCntResponse.self))
    //                print(response.data)
    //
    //                postCounts = response.data
    //                numbers = response.data
    //
    //                number = numbers.reduce(0, { $0 + $1 })
    //
    //            } catch APIError.responseError(let statusCode) {
    //                print("myPageViewModel - statusCode: ", statusCode)
    //            } catch APIError.transportError {
    //                callback()
    //            }
    //        }
    //    }
    
    
}



