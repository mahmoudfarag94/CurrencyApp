//
//  BaseViewController.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import UIKit
import RxSwift
import RxRelay

//import NVActivityIndicatorView

class BaseViewController<T: BaseViewModel>: UIViewController {

    var viewModel: T?

    lazy var loaderView: IndicatorView = {
        let nib = UINib(nibName: IndicatorView.id, bundle: nil)
        let loader = nib.instantiate(withOwner: self, options: nil).first as! IndicatorView
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backButtonTitle = ""
        let back =  BackBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        back.tintColor = .lightGray
        self.navigationItem.backBarButtonItem = back
        self.view.backgroundColor = .white
    }
    
    func setupView(){
        
    }
    
    func bindSubscribers(){
        guard let viewModel = viewModel else {return}
        viewModel.loaderRelay.subscribe(onNext: {[weak self] value in
            guard let self = self else {return}
            value == true ? self.startLoader() : self.stopLoader()
        }).disposed(by: viewModel.bag)
        
        viewModel.errorRelay.subscribe(onNext: { error in
            self.HandleError(error: error)
        }).disposed(by: viewModel.bag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func startLoader(){
        self.Loading()
    }
    
    func stopLoader(){

        self.stopLoading()
    }
}

class BackBarButtonItem: UIBarButtonItem {
    @available(iOS 14.0, *)
    override var menu: UIMenu? {
        set {
            /* Don't set the menu here */
            /* super.menu = menu */
        }
        get {
            return super.menu
        }
    }
}
