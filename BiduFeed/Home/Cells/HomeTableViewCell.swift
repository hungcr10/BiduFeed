
import UIKit

class HomeTableViewCell: UITableViewCell {
    private var check = true
    private var numberFavoriteReact = 34
    private var images: String = ""
//MARK: -IBOutlet
    @IBOutlet weak var reactView: UIView!
    @IBOutlet weak var followView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var avtImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var hangstagLabel: UILabel!
    @IBOutlet weak var favoriteReactLabel: UILabel!
    @IBOutlet weak var favoriteReactImg: UIImageView!
}
//MARK: - Life Cycle
extension HomeTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
        CacheImgae.shared.fetchUrl { data in
            self.images = data.images
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
        
    }
}
//MARK: - Button
extension HomeTableViewCell {
    @IBAction func favoriteReactBtn(_ sender: Any) {
        if check == true {
            favoriteReactImg.image = UIImage(named: "redheart")
            favoriteReactLabel.text = "\(numberFavoriteReact + 1 )"
            check = false
        } else {
            favoriteReactImg.image = UIImage(named: "heart")
            favoriteReactLabel.text = "\(numberFavoriteReact)"
            check = true
        }
    }
    @IBAction func followBtn(_ sender: Any) {
        followView.isHidden = true
    }
}
//MARK: - Helper
extension HomeTableViewCell {
    func setUpCollectionView() {
        mainCollectionView.register(UINib(nibName: Contants.collectionNibName, bundle: nil), forCellWithReuseIdentifier: Contants.collectionIdentifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    func setUpView() {
        avtImage.layer.cornerRadius = avtImage.frame.height / 2
        avtImage.layer.borderWidth = 2.0
        avtImage.layer.borderColor = UIColor.red.cgColor
        avtImage.clipsToBounds = true
        reactView.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        reactView.layer.maskedCorners = [.layerMinXMaxYCorner,
                                    .layerMinXMinYCorner]
        reactView.layer.cornerRadius = 10
        followView.layer.cornerRadius = followView.frame.height / 2
        favoriteReactImg.image = UIImage(named: "heart")
        favoriteReactLabel.text = "\(numberFavoriteReact)"
}
    func configure(with model: Info) {
        self.nameLabel.text = model.infoName
        self.avtImage.image = model.imageConvert
        self.statusLabel.text = model.status
        self.timeLabel.text = model.time
        self.hangstagLabel.text = model.hagtag
    }
    
}
//MARK: - UICollectionViewDataSource
extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: Contants.collectionIdentifier, for: indexPath) as! HomeCollectionViewCell
        cell.configUI(urlImage: images)
        return cell
    }
    
    
}
//MARK: - UICollectionViewDelegate
extension HomeTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
