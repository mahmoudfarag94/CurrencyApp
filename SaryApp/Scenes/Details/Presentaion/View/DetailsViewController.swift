//
//  DetailsViewController.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import UIKit
import RxSwift


class HistoricalUIModel{
    
    
}

class DetailsViewController: BaseViewController<DetailsViewModel> {

    @IBOutlet weak var ratesDetailsTblView: UITableView!
    var base:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailsViewModel(historicalUsacase: DetailsUseCase(), latestUsacase: LatestUseCase())
        bindSubscribers()
    }
    
    override func bindSubscribers() {
        super.bindSubscribers()
        
        guard let viewModel = viewModel else {return}
        ratesDetailsTblView.register(cellType: RateTableViewCell.self)
        viewModel.ratesPublisher.bind(to: ratesDetailsTblView.rx.items(cellIdentifier: "RateTableViewCell", cellType: RateTableViewCell.self)){(index, item, cell) in
            cell.setData(model: item)
        }.disposed(by: viewModel.bag)
        
        viewModel.getLatestData(base: base)
        
    }
}
