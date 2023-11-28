//
//  Monthpost.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/25/23.
//

import Foundation

class MonthPost: ObservableObject {
//    var postId : Int = 0
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
//        postId = postmonthresponse.data?.first?.postId ?? 0
//        if let firstData = postmonthresponse.data?.first {
//            postId = firstData.postId
//        } else {
//            // 적절한 오류 처리 또는 기본 값 설정
//        }

//        if let postId = postmonthresponse.data?.first?.postId {
////           MonthPost.shared.postId = postId
//            MonthPost.shared.postId = postId
//            
//        }
        return postmonthresponse
    }
    
    static func userpostMonth(month: Int) async throws -> Response<[DataModel]> {
        let year = 2023
        let userId = MyPageViewModel.shared.userId
        let response = try await HttpClient.request(HttpRequest(url: "post/month/\(year)/\(month)/\(userId)", method: .get, model: Response<[DataModel]>.self))
        
        print(response)
        
        return response
    }
}
