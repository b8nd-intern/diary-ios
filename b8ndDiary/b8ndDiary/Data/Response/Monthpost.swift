//
//  Monthpost.swift
//  b8ndDiary
//
//  Created by dgsw8th61 on 11/25/23.
//

import Foundation

class MonthPost: ObservableObject {
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
        let response = try await HttpClient.request(HttpRequest(url: "post/month/\(year)/\(month)", method: .get, model: Response<[DataModel]>.self))
        
        print(response)
        
        return response
    }
}
