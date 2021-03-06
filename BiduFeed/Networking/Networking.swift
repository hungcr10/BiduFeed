import UIKit

//MARK: - FetchItem
class Networking {
    let isConnected = true
    static let shared = Networking()
    let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    func fetchItem(completion: @escaping (_:PostModel) -> Void) {
        guard isConnected else { return }
        guard let baseUrl = URL(string:"https://dog.ceo/api/breed/hound/afghan/images") else
        { return }
        let session = URLSession.shared
        let task = session.dataTask(with: baseUrl) { data, _, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let output = try JSONDecoder().decode(PostModel.self, from: data)
                completion(output)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: - Fetch Image
    func fetchImage(url: String, completion: @escaping (_: Data) -> Void) {
        guard isConnected else { return }
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

