
import Foundation
import UIKit
struct ImageModel: Codable {
    let images: [String]
    enum CodingKeys: String, CodingKey {
        case images = "message"
    }
}

//MARK: - FetchItem
class Networking {
    let documents = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    static let shared = Networking() // singleton
    
    func loadData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let fileCachePath = FileManager.default.temporaryDirectory
            .appendingPathComponent(
                url.lastPathComponent,
                isDirectory: false
            )
        
        if let data = Data(contentsOfFile: documents.path) {
            completion(data, nil)
            return
        }
        
        download(url: url, toFile: documents) { (error) in
            let data = Data(contentsOfFile: documents.path)
            completion(data, error)
        }
    }
    
}
