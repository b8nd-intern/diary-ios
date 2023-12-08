//
//  Monthpost.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/25/23.
//

import Foundation
import Alamofire

class MonthPostViewModel: ObservableObject {
    @Published var postIds : [Int] = []
    @Published var userId : String = ""
    
    var myuserId = MyPageViewModel.shared.myuserId
    
    @Published var dataModels: [DataModel] = []
    
    @Published var offset: CGFloat = 0
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
    

    func postMonth(month: Int) async throws -> Response<[DataModel]> { // month 매개변수 추가
        let year = 2023
        let postmonthresponse = try await HttpClient.request(HttpRequest(url: "post/month/\(year)/\(month)", method: .get, model: Response<[DataModel]>.self))
        
        print(postmonthresponse)

        return postmonthresponse
    }
    
    
    func userpostMonth(month: Int, userId: String) async throws -> Response<[DataModel]> {
        let year = 2023
        let response = try await HttpClient.request(HttpRequest(url: "post/monthForEvery/\(year)/\(month)/\(userId)", method: .get, model: Response<[DataModel]>.self))

        print(response)

        return response
    }

    func postdelete(callback: @escaping () -> Void) {
        let body : Parameters = [
            "postId" : postIds
        ]
        Task{
            do {
                let deleteresponse  = try await HttpClient.request(HttpRequest(url: "post/delete", method:.delete ,params: body, model:Response<PostDeleteResponse>.self))
                print("삭제 확인하기 :\(String(describing: deleteresponse.data))")
                
                
            } catch APIError.responseError(let statusCode) {
                print("postdelete - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    

    func extractPostIds(from response: Response<[DataModel]>) -> [Int]? {
        guard response.status == 200 else {
            // Handle error case, e.g., return nil or throw an error
            print("Error: \(response.message)")
            return nil
        }

        let postIds = response.data?.compactMap { $0.postId }
        return postIds
    }
    
    
}
