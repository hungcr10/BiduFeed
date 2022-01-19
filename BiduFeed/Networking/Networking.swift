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
    static let shared = Networking()
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func fetchItem(completion: @escaping (_:ImageModel) -> Void) {
        guard let baseUrl = URL(string:"https://dog.ceo/api/breed/hound/afghan/images/random/3") else
        { return }
        let session = URLSession.shared
        let task = session.downloadTask(with: baseUrl) { data, _, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let output = try JSONDecoder().decode(ImageModel.self, from: Data(contentsOf: data))
                completion(output)
                print(output)
                try FileManager.default.copyItem(at: data, to: self.documents.appendingPathComponent(self.imageDataName(from: data.path)!))
                print("hhh \(self.documents)")
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    //MARK: - Fetch Image
    func fetchImage(url: String, completion: @escaping (_: Data) -> Void) {
         let pathComponent = documents.appendingPathComponent(url)
        let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                let imageData = loadImage(url: url)
                guard let imageData = imageData else {
                    return
                }
                completion(imageData)
            } else {
                let session = URLSession.shared
                guard let baseURL = URL(string: url) else {
                    return
                }
                let task = session.dataTask(with: baseURL) { data, _, error in
                    guard error == nil else { return }
                    guard let data = data else { return }
                    completion(data)
                }
                task.resume()            }
    }
    func loadImage(url: String) -> Data? {
        let fileUrl = documents.appendingPathComponent(url)
        do {
            let imageData = try Data(contentsOf: fileUrl)
            return imageData
        } catch {
            print("error to load image\(error)")
            return nil
        }
    }
    func imageDataName(from urlString: String) -> String? {
        guard var base64String = urlString.data(using: .utf8)?.base64EncodedString() else {return nil}
        base64String = base64String.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
        guard base64String.count < 10 else {
            return String(base64String.dropFirst(base64String.count - 10))
        }
        return base64String
    }
    
}

