import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.contentMode = .scaleAspectFill
    }
    func configUI(urlImage: String) {
        let fileDocument = Networking.shared.documents
        let myFile = fileDocument.appendingPathComponent(urlImage).lastPathComponent
        let myFileDocument = fileDocument.appendingPathComponent(myFile)
        if Networking.check.connection != .unavailable {
            Networking.shared.fetchImage(url: urlImage) { data in
                try? data.write(to: myFileDocument)
                print(myFileDocument)
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                }
                let directoryContents = try? FileManager.default.contentsOfDirectory(at: fileDocument, includingPropertiesForKeys: nil, options: [])
                guard let directoryContents = directoryContents else {return}
                if directoryContents.count > 50 {
                    try? FileManager.default.removeItem(at: directoryContents.first!)
                }
              print("numbers of documents: \(directoryContents.count)")
           }
        } else {
            mainImageView.image = Networking.shared.loadImage(url: urlImage)
        }
    }
}
