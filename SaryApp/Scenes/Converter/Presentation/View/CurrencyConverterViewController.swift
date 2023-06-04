//
//  CurrencyConverterViewController.swift
//  CurrencyApp
//
//  Created by Mahmoud Farag on 03/06/2023.
//

import UIKit
import RxSwift
import RxRelay

class CurrencyConverterViewController: BaseViewController<CurrencyConverterViewModel> {
    
    @IBOutlet weak var fromCurrencyDropDwon: UITextField!
    @IBOutlet weak var toCurrencyDropDwon: UITextField!
    @IBOutlet weak var fromAmount: UITextField!
    @IBOutlet weak var toAmount: UITextField!
    @IBOutlet weak var detailsBtn: UIButton!
    @IBOutlet weak var swapCurrencyBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CurrencyConverterViewModel(usecase: CurrencyUseCase())
        bindSubscribers()
    }
    
    override func bindSubscribers() {
        super.bindSubscribers()
        guard let viewModel = viewModel else {return}
        
        fromCurrencyDropDwon.rx.controlEvent(.editingDidBegin).subscribe(onNext :{ [self] in
            fromCurrencyDropDwon.resignFirstResponder()
            let dropDown = self.setDropDownMenu(view: fromCurrencyDropDwon, width: fromCurrencyDropDwon.bounds.width) { [weak self](text, index) in
                self?.fromCurrencyDropDwon.text = text
                //handle action.
//                viewModel.coutnryCodeRelay.accept(text)
            }
            dropDown.dataSource = viewModel.symbolsPublisher.value.map{$0.key ?? ""}
            dropDown.show()
        }).disposed(by: viewModel.bag)
        
        toCurrencyDropDwon.rx.controlEvent(.editingDidBegin).subscribe(onNext :{ [self] in
            toCurrencyDropDwon.resignFirstResponder()
            let dropDown = self.setDropDownMenu(view: toCurrencyDropDwon, width: toCurrencyDropDwon.bounds.width) { [weak self](text, index) in
                self?.toCurrencyDropDwon.text = text
                //handle action.
//                viewModel.coutnryCodeRelay.accept(text)
            }
            dropDown.dataSource = viewModel.symbolsPublisher.value.map{$0.key ?? ""}
            dropDown.show()
        }).disposed(by: viewModel.bag)

        let vm = DetailsViewModel(historicalUsacase: DetailsUseCase(), latestUsacase: LatestUseCase())
        
    }
    
}
