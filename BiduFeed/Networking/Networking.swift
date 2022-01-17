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
    func fetchItem(completion: @escaping (_:ImageModel) -> Void) {
        let session = URLSession.shared
        guard let baseUrl = URL(string:"https://dog.ceo/api/breed/hound/afghan/images/random/3") else {
            return
        }
        let task = session.dataTask(with: baseUrl) { data, _, error in
            guard error == nil else { return }
            guard let data = data else { return }
            
            do {
                let output = try JSONDecoder().decode(ImageModel.self, from: data)
                completion(output)
                print(output)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    //MARK: - Fetch Image
    func fetchImage(url: String, completion: @escaping (_: Data) -> Void) {
        let session = URLSession.shared
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        guard let baseURL = URL(string: url) else {
            return
        }
        let task = session.downloadTask(with: baseURL) { [self] data, response, error in
            guard error == nil else { return }
            guard let data = data else { return }
            let datas = try! Data(contentsOf: data)
            completion(datas)
            if FileManager.default.fileExists(atPath: documents.path) {
                let imageData = loadImage(from: documents)
            } else {
                do {
                    try FileManager.default.moveItem(at: data, to: documents.appendingPathComponent(imageDataName(from: url)!))
                } catch {
                    print(error)
                    
                }
            }
            
            print("alo \(documents)")
        }
        task.resume()
    }
    func loadImage(from url: URL){
      do {
        let imageData = try Data(contentsOf: url)
      } catch {
        print(error.localizedDescription)
     }
    }
     func imageDataName(from urlString: String) -> String? {
      guard var base64String = urlString.data(using: .utf8)?.base64EncodedString() else {return nil}
      base64String = base64String.components(separatedBy: CharacterSet.alphanumerics.inverted).joined()
      guard base64String.count < 50 else {
        return String(base64String.dropFirst(base64String.count - 50))
      }
      return base64String
    }
    
}
