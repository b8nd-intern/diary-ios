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



