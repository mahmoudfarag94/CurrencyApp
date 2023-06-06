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
        viewModel = CurrencyConverterViewModel(usecase: CurrencyUseCase(), detailsUseCase: LatestUseCase())
        bindSubscribers()
    }
    
    
    override func bindSubscribers() {
        super.bindSubscribers()
        guard let viewModel = viewModel else {return}
        
        fromCurrencyDropDwon.rx.controlEvent(.editingDidBegin).subscribe(onNext :{ [self] in
            fromCurrencyDropDwon.resignFirstResponder()
            let dropDown = self.setDropDownMenu(view: fromCurrencyDropDwon, width: fromCurrencyDropDwon.bounds.width) { [weak self](text, index) in
                self?.fromCurrencyDropDwon.text = text
                self?.viewModel?.fromAmountPublisher.accept("1")
                self?.viewModel?.basePublisher.accept(text)
                self?.toAmount.text = String(format: "%.2f", self?.viewModel?.calculate() ?? 0.0)
                self?.viewModel?.getLatestData()
            }
            dropDown.dataSource = viewModel.symbolsPublisher.value.map{$0.key ?? ""}
            dropDown.show()
        }).disposed(by: viewModel.bag)
        
        toCurrencyDropDwon.rx.controlEvent(.editingDidBegin).subscribe(onNext :{ [self] in
            toCurrencyDropDwon.resignFirstResponder()
            let dropDown = self.setDropDownMenu(view: toCurrencyDropDwon, width: toCurrencyDropDwon.bounds.width) { [weak self](text, index) in
                self?.toCurrencyDropDwon.text = text
                let rate = viewModel.latestRelay.value.first{$0.key == text}
                self?.viewModel?.ToAmountPublisher.accept("\(rate?.value ?? 0.0)")
                self?.viewModel?.targetPublisher.accept(text)
            }
            dropDown.dataSource = viewModel.symbolsPublisher.value.map{$0.key ?? ""}
            dropDown.show()
        }).disposed(by: viewModel.bag)
        
        fromAmount.rx.text.orEmpty.changed.bind(to: viewModel.fromAmountPublisher).disposed(by: viewModel.bag)
        viewModel.fromAmountPublisher.subscribe(onNext: { [weak self] text in
            self?.fromAmount.text = text
            self?.toAmount.text = String(format: "%.2f", self?.viewModel?.calculate() ?? 0.0)
        }).disposed(by: viewModel.bag)
        
        toAmount.rx.text.orEmpty.changed.bind(to: viewModel.ToAmountPublisher).disposed(by: viewModel.bag)
        viewModel.ToAmountPublisher.subscribe(onNext: { [weak self] text in
            self?.toAmount.text = String(format: "%.2f", self?.viewModel?.calculate() ?? 0.0)
        }).disposed(by: viewModel.bag)
        
        
        detailsBtn.rx.tap.subscribe(onNext: {
            let details = DetailsViewController.init(nibName: "DetailsViewController", bundle: nil)
            details.base = viewModel.basePublisher.value
            self.navigationController?.pushViewController(details, animated: true)
        }).disposed(by: viewModel.bag)
    }
    
}
