
import Foundation

struct ImageModel: Codable {
    let images: [String]
    
    enum CodingKeys: String, CodingKey {
        case images = "message"
    }
}
class Networking {
    static let shared = Networking()
    func fetchItem(completion: @escaping (_:ImageModel) -> Void) {
        let session = URLSession.shared
        guard let baseUrl = URL(string:"https://dog.ceo/api/breed/hound/afghan/images/random/3") else {
            print("sasas")
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
    
}
