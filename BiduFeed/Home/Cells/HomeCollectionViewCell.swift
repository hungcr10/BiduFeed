import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.contentMode = .scaleAspectFill
    }
    
    func configUI(urlImage: String) {
        if FileManager.default.fileExists(atPath: Networking.shared.documents.path) {
            let fileUrl = Networking.shared.documents.appendingPathComponent(urlImage)
            do {
                    let imageData = try? Data(contentsOf: fileUrl)
                    guard let imageData = imageData else {return}
                    self.mainImageView.image = UIImage(data: imageData)
                
            } catch {
                print("error to load image\(error)")
            }
        } else {
            Networking.shared.fetchImage(url: urlImage) { data in
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                }
            }
        }
        
    }
    
}
