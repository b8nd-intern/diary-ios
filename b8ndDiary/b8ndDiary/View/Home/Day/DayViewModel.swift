//
//  DayViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/26/23.
//

import Foundation

class DayViewModel: ObservableObject {
    
    @Published var dayList: [DayModel] = []
    

    static func getRecordWeek() async throws -> Response<[DayModel]> {
        let response = try await HttpClient.request(HttpRequest(url: "record/records/week", method: .get, model: Response<[DayModel]>.self))
        return response
    }
    
    func initDiaryList() async {
        do {
            let data = try await DayViewModel.getRecordWeek()
            dayList = data.data ?? []
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
}

struct DayModel: Codable {
    
    var date: String
    var isDone: Bool
}
