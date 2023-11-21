

import Foundation
import Alamofire





struct PostCntResponse : Codable {
    let status: Int
    let message: String
    let data: [Int]
}
