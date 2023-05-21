//
//  BannerCollectionViewCell.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 18/05/2023.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    static let identifier = "BannerCollectionViewCell"
    @IBOutlet weak var bannerImageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(model: BannerModel){
        bannerImageCell.setImage(urlString: model.image ?? "")
        
    }
    
}
