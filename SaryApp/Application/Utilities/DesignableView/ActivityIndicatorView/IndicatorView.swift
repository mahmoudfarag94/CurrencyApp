//
//  IndicatorView.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import UIKit
import NVActivityIndicatorView


class IndicatorView: UIView {

    static let id  = "IndicatorView"
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLoaderView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoaderView()
    }

    func loadFromNib()->IndicatorView{
        let view = UINib(nibName: "IndicatorView", bundle: nil).instantiate(withOwner: self, options: nil).first as! IndicatorView
        return view
    }
    
    func setupLoaderView(){
        let view = loadFromNib()
        loaderView.type = .ballSpinFadeLoader
        loaderView.color = .darkGray
        containerView.addSubview(view)
    }
}


