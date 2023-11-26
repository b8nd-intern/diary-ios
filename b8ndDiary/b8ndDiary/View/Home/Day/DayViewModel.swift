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
    
    @MainActor
    func initDiaryList() {
        Task {
            do {
                print("home viewmodel - request...")
//                let data = try await Record.getRecordWeek()
                let data = try await DayViewModel.getRecordWeek()
                dayList = data.data!
                print("DayViewModel - \(dayList)")
            } catch (let e) {
                print(e.localizedDescription)
            }
        }
    }
}

struct DayModel: Codable {
    
    var date: String
    var isDone: Bool
}
