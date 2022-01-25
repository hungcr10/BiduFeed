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
    static let checkConnect = try! Reachability()
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func fetchItem(completion: @escaping (_:ImageModel) -> Void) {
        let directoryContents = try? FileManager.default.contentsOfDirectory(at: self.documents, includingPropertiesForKeys: nil, options: [])
        guard let directoryContents = directoryContents else { return }
        
        if Networking.checkConnect.connection != .unavailable {
            guard let baseUrl = URL(string:"https://dog.ceo/api/breed/hound/afghan/images") else
            { return }
            let session = URLSession.shared
            let task = session.downloadTask(with: baseUrl) { data, _, error in
                guard error == nil else { return }
                guard let data = data else { return }
                do {
                    let output = try JSONDecoder().decode(ImageModel.self, from:Data(contentsOf: data))
                    completion(output)
                    //  print(output)
                } catch {
                    print(error)
                }
            }
            task.resume()
            print("Internet is connected")
            
        } else {
            let imagesLocal = directoryContents.map { $0.lastPathComponent }
            let imagesArr = ImageModel.init(images: imagesLocal)
            completion(imagesArr)
            print("Internet is not connected")
        }
        
        
    }
    //MARK: - Fetch Image
    func fetchImage(url: String, completion: @escaping (_: Data) -> Void) {
        let session = URLSession.shared
        guard let baseURL = URL(string: url) else {
            return
        }
        let task = session.dataTask(with: baseURL) { data, _, error in
            guard error == nil else { return }
            guard let data = data else { return }
            completion(data)
            
        }
        task.resume()
    }
    
        func loadImage(url: String) -> UIImage? {
            let fileURL = documents.appendingPathComponent(url)
            print("aa \(fileURL)")
            do {
                let imageData = try Data(contentsOf: fileURL)
                return UIImage(data: imageData)
            } catch {
                print("error to load image\(error)")
                return nil
            }
        }
    
}

