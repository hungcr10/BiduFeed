import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
}
//MARK: - Config UI
extension HomeCollectionViewCell {
    func configUI(urlImage: URL?) {
        let fileDocument = FileManager.default.urls(for: .documentDirectory,
                                                       in: .userDomainMask).first!
        let myImgs = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask).first!.appendingPathComponent(Constants.URLImages)
        guard let urlImage = urlImage else { return }
        let myFile = urlImage.lastPathComponent
        let imageFileDocument = myImgs.appendingPathComponent(myFile)
        if FileManager.default.fileExists(atPath: imageFileDocument.path) {
            let imageData = try! Data(contentsOf: imageFileDocument)
            mainImageView.image = UIImage(data: imageData)
        } else {
            Networking.shared.fetchImage(url: urlImage.absoluteString) { data in
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                }
                do {
                    try data.write(to: myImgs)
                    let directoryContents = try? FileManager.default.contentsOfDirectory(at: myImgs, includingPropertiesForKeys: nil, options: [])
                    guard let directoryContents = directoryContents else {return}
                    if directoryContents.count > 50 {
                        try? FileManager.default.removeItem(at: directoryContents.first!)
                    }
                } catch  {
                    print(error)
                }
            }
        }
        print("Document \(fileDocument)")

    }
}

