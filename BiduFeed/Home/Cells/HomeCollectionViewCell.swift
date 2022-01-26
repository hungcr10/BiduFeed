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
        if !FileManager.default.fileExists(atPath: myImgs.absoluteString) {
            try? FileManager.default.createDirectory(atPath: myImgs.path, withIntermediateDirectories: false, attributes: nil)
        }
        guard let urlImage = urlImage else { return }
        let myFile = urlImage.lastPathComponent
        let imageFileDocument = fileDocument.appendingPathComponent(myFile).lastPathComponent
        let fileImgs = myImgs.appendingPathComponent(imageFileDocument)
        print("aa", fileImgs)
        print("Document \(fileDocument)")
        if FileManager.default.fileExists(atPath: fileImgs.path) {
            let imageData = try! Data(contentsOf: fileImgs)
            mainImageView.image = UIImage(data: imageData)
        } else {
            Networking.shared.fetchImage(url: urlImage.absoluteString) { data in
                DispatchQueue.main.async {
                    self.mainImageView.image = UIImage(data: data)
                }
                do {
                    try data.write(to: fileImgs)
                } catch  {
                    print(error)
                }
            }
        }
        let directoryContents = try? FileManager.default.contentsOfDirectory(at: fileImgs, includingPropertiesForKeys: nil, options: [])
        guard let directoryContents = directoryContents else {return}
        if directoryContents.count > 50 {
            try? FileManager.default.removeItem(at: directoryContents.first!)
        }
    }
}

