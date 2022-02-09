import UIKit

struct PostModel: Codable {
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case images = "message"
    }
}

