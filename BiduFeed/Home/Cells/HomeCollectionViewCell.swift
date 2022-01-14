//
//  HomeCollectionViewCell.swift
//  BiduFeed
//
//  Created by CristianoDaoHung on 11/01/2022.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.contentMode = .scaleAspectFill
    }
    
    func configUI(urlImage: String) {
       Networking.shared.fetchImage(url: urlImage) { data in
            DispatchQueue.main.async {
                self.mainImageView.image = UIImage(data: data)
            }
        }
        
    }

}
