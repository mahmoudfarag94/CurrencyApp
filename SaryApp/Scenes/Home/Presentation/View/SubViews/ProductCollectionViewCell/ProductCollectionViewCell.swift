//
//  ProductCollectionViewCell.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 18/05/2023.
//

import UIKit
import Kingfisher

class ProductCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setData(model: CatelogDataModel){
        if let url = model.image {
            productImgView.setImage(urlString: url)
        }
        productNameLbl.text = model.name ?? ""
    }
    
}
