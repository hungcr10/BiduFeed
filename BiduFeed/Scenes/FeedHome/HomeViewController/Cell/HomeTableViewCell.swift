
import UIKit

class HomeTableViewCell: UITableViewCell {
    //MARK: -IBOutlet
    @IBOutlet weak var reactView: UIView!
    @IBOutlet weak var followView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var avtImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var hangstagLabel: UILabel!
    @IBOutlet weak var favoriteReactLabel: UILabel!
    @IBOutlet weak var favoriteReactImageView: UIImageView!
    var images = [String]()
    private var check = true
    private var numberFavoriteReact = 34
}

//MARK: - Life Cycle
extension HomeTableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
        setUpView()
    }
}

//MARK: - Button
extension HomeTableViewCell {
    @IBAction func favoriteReactBtn(_ sender: Any) {
        if check == true {
            favoriteReactImageView.image = UIImage(named: "redheart")
            favoriteReactLabel.text = "\(numberFavoriteReact + 1 )"
            check = false
        } else {
            favoriteReactImageView.image = UIImage(named: "heart")
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
    private func setUpCollectionView() {
        mainCollectionView.registerCell(HomeCollectionViewCell.cellIdentifier)
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.isPagingEnabled = true
    }
    
    private func setUpView() {
        avtImageView.layer.cornerRadius = avtImageView.frame.height / 2
        avtImageView.layer.borderWidth = 2.0
        avtImageView.layer.borderColor = UIColor.red.cgColor
        avtImageView.clipsToBounds = true
        reactView.backgroundColor = UIColor(white: 1.0, alpha: 0.3)
        reactView.layer.maskedCorners = [.layerMinXMaxYCorner,
                                         .layerMinXMinYCorner]
        reactView.layer.cornerRadius = 15
        followView.layer.cornerRadius = followView.frame.height / 2
        favoriteReactImageView.image = UIImage(named: "heart")
        favoriteReactLabel.text = "\(numberFavoriteReact)"
    }
    
    func configure(with model: Info, image: [String]) {
        nameLabel.text = model.infoName
        avtImageView.image = model.imageConvert
        statusLabel.text = model.status
        timeLabel.text = model.time
        hangstagLabel.text = model.hangstag
        self.images = image
    }
}

//MARK: - UICollectionViewDataSource
extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        let urlImage = URL(string: images[indexPath.row])
        cell.configUI(urlImage: urlImage)
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
