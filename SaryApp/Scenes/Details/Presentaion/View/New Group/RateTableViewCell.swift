//
//  RateTableViewCell.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import UIKit

class RateTableViewCell: UITableViewCell {

    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(model: RateModel){
        rateLbl.text = "\(model.value ?? 0.0)"
        symbolLbl.text = model.key
    }
    
}
