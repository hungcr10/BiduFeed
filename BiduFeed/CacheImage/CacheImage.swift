
import Foundation

struct ImageModel: Codable {
    let images: String
}
class CacheImgae {
    static let shared = CacheImgae()
    func fetchUrl(completion: @escaping (_:ImageModel) -> Void) {
        let session = URLSession.shared
    guard let baseUrl = URL(string:"https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_1080.jpg") else {
            print("sasas")
            return
        }
        let task = session.dataTask(with: baseUrl) { data, _, error in
            print("abcde")
            guard let error = error else {return}
            guard let data = data else {return}
            do {
                let output = try JSONDecoder().decode(ImageModel.self, from: data)
                completion(output)
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
