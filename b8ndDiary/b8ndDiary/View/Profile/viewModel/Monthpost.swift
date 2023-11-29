//
//  Monthpost.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/25/23.
//

import Foundation
import Alamofire

class MonthPost: ObservableObject {
    @Published var postIds : [Int] = []
    @Published var userId : String = ""
//    @Published var postId : Int = 0
//    static let shared = MonthPost()
    
    var myuserId = MyPageViewModel.shared.myuserId
    
    @Published var dataModels: [DataModel] = []
    
    @Published var offset: CGFloat = 0
    //    @Published var direct: Direct = .none
    private var originOffset: CGFloat = 0
    private var isCheckedOriginOffset: Bool = false
    
    func setOriginOffset(_ offset: CGFloat) {
        guard !isCheckedOriginOffset else { return }
        self.originOffset = offset
        self.offset = offset
        isCheckedOriginOffset = true
    }
    
    func setOffset(_ offset: CGFloat) {
        guard isCheckedOriginOffset else { return }
        self.offset = offset
    }
    

    static func postMonth(month: Int) async throws -> Response<[DataModel]> { // month 매개변수 추가
        let year = 2023
        let postmonthresponse = try await HttpClient.request(HttpRequest(url: "post/month/\(year)/\(month)", method: .get, model: Response<[DataModel]>.self))
        
        print(postmonthresponse)

        return postmonthresponse
    }
    
    
    static func userpostMonth(month: Int, userId: String) async throws -> Response<[DataModel]> {
        let year = 2023
        let response = try await HttpClient.request(HttpRequest(url: "post/monthForEvery/\(year)/\(month)/\(userId)", method: .get, model: Response<[DataModel]>.self))

        print(response)

        return response
    }

    func Postdelete(callback: @escaping () -> Void) {
        let body : Parameters = [
            "postId" : postIds
        
        ]
        Task{
            do {
//                print(" 달 포스트 아이디 확인 : \(postId)")
                let deleteresponse  = try await HttpClient.request(HttpRequest(url: "post/delete", method:.delete ,params: body, model:Response<PostdeleteResponse>.self))
                print("삭제 확인하기 :\(String(describing: deleteresponse.data))")
                
                
            } catch APIError.responseError(let statusCode) {
                print("postdelete - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    func Postupdate(callback: @escaping () -> Void) {
        let body : Parameters = [
            "postId" : 65,
            "content": "수정 성공",
            "color": "yellow",
            "emoji": "smile",
            "isSecret": true
        
        ]
        Task{
            do {
//                print(" 달 포스트 아이디 확인 : \(postId)")
                let updateresponse  = try await HttpClient.request(HttpRequest(url: "post/update", method:.patch ,params: body, model:PostupdateResponse.self))
                print(updateresponse)
                
            } catch APIError.responseError(let statusCode) {
                print("postdelete - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    func PostRead(callback: @escaping () -> Void) {
        let param = 80
        Task{
            do {
//                print(" 달 포스트 아이디 확인 : \(postId)")
                let readresponse  = try await HttpClient.request(HttpRequest(url: "post/read/\(param)", method:.get, model:Response<DataModel>.self))
                print(readresponse)
                
            } catch APIError.responseError(let statusCode) {
                print("postdelete - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    static func extractPostIds(from response: Response<[DataModel]>) -> [Int]? {
        guard response.status == 200 else {
            // Handle error case, e.g., return nil or throw an error
            print("Error: \(response.message)")
            return nil
        }

        let postIds = response.data?.compactMap { $0.postId }
        return postIds
    }
    
    
}
