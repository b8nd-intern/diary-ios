

import Foundation
import Alamofire





struct PostCntResponse : Codable {
    let status: Int
    let message: String
    let data: [Int]
}


class PostCountsData: ObservableObject {
    
    @Published var postCounts: [Int] = [0]
    @Published var numbers: [Int] = [0]
    @Published var number: Int = 0
    func PostYearCnt() {
            let params = ["year": 2023 ]
            Task{
                do {
          
                    let response  = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method:.get ,params: params , model: PostCntResponse.self))
                    print(response.data)
  
                    postCounts = response.data
                    numbers = response.data
                    
              
                    numbers.reduce(0) { (a: Int, b: Int) -> Int in
                        return a + b
                    }
                    number = numbers[0]
        
                }
                catch APIError.responseError(let statusCode) {
                    print("서버 응답 오류: HTTP 상태 코드 \(statusCode)")
                } catch {
                   
                    print("Post cnt 오류: \(error)")
            
                }
            }
        }
    
        
}
    


