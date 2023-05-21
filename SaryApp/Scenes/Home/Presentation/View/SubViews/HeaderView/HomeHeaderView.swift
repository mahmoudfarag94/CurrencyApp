//
//  HomeHeaderView.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 18/05/2023.
//

import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerLbl: UILabel!
    
    func configuration(model: CatelogModel){
        if model.showTitle ?? false{
            headerLbl.text = model.title ?? ""
        }else {
            headerLbl.text = ""
        }
    }
}
