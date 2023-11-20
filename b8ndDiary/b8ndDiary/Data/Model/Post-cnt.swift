

import Foundation
import Alamofire

//struct PostcntResponse: Codable {
//    let cnt: Int
//}
//
//    
//    class PostCountsData: ObservableObject {
//        @Published var postCounts: [Int] = []
//        
//
//        
//        func fetchPostCountsAndNavigateToMypage() {
//            Task {
//                await fetchPostCounts()
//            }
//        }
//        
//        private func fetchPostCounts() async {
//            try? await withThrowingTaskGroup(of: PostcntResponse?.self) { taskGroup in
//                for month in 1...12 {
//                    taskGroup.addTask {
//                        do {
//                            let url = "http://15.164.163.4/record/post-cnt?month=\(month)"
//                            
//                            let response = try await HttpClient.request(httpRequest: HttpRequest(url: url, method: .get, headers: ["Accept": "application/json"], model: BaseResponse<PostcntResponse?>.self))
//                            
//                            if let responseData = response.data {
//                                // 옵셔널 값을 언래핑하여 사용
//                                return responseData
//                            } else {
//                                // 옵셔널 값이 nil인 경우, 기본값이나 예외 처리 등을 수행
//                                throw APIError.unknownError
//                            }
//                        } catch APIError.responseError(let statusCode) {
//                            print("서버 응답 오류: HTTP 상태 코드 \(statusCode)")
//                            return nil
//                        } catch {
//                            print("오류: \(error)")
//                            return nil
//                        }
//                    }
//                }
//
//                for _ in 1...12 {
//                    if let result = try? await taskGroup.next() {
//                        if let cnt = result?.cnt {
//                            postCounts.append(cnt)
//                        }
//                    } else {
//                        print("실패")
//                    }
//                }
//}
//}
//}
//
//





//class PostCountsData: ObservableObject {
//    @Published var postCounts: [Int] = []
//
//    func fetchPostCountsAndNavigateToMypage() {
//        for month in 1...12 {
//            let params = ["month": month]
//
//            AF.request("http://15.164.163.4/record/post-cnt", method: .get, parameters: params)
//                .validate(statusCode: 200..<300)
//                .responseDecodable(of: PostcntResponse.self) { response in
//                    switch response.result {
//                    case .success(let postCntResponse):
//                        if response.response?.statusCode == 403 {
//                            // Handle 403 Forbidden error
//                            print("Access Forbidden: \(response)")
//                            // You can perform additional actions here if needed
//                        } else if postCntResponse.cnt != 0 {
//                            self.postCounts.append(postCntResponse.cnt)
//                        } else {
//                            // Handle the case where cnt is 0
//                            print("Received 0 count for month \(month)")
//                        }
//                    case .failure(let error):
//                        // Handle other types of errors
//                        print("Error: \(error)")
//                    }
//                }
//        }
//    }
//}


struct PostcntResponse: Codable {
    let cnt: Int
}


class PostCountsData: ObservableObject {
    
    @Published var postCounts: [Int] = []
    func fetchPostCountsAndNavigateToMypage() {
        
        for month in 1...12 {
            let params = ["month": month]
            Task{
                do {
                    let response  = try await HttpClient.request(httpRequest: HttpRequest(url: "http://15.164.163.4/record/post-cnt", method:.get ,params: params , model: Response<PostcntResponse>.self))
                    print("\(response)")
                    postCounts.append(response.data.cnt)
        
                }
                catch APIError.responseError(let statusCode) {
                    print("서버 응답 오류: HTTP 상태 코드 \(statusCode)")
                } catch {
                   
                    print("오류: \(error)")
                    
                }
            }
        }
    }
        
}
    


