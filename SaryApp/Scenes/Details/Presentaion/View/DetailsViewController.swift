//
//  DetailsViewController.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import UIKit
import RxSwift


class DetailsViewController: BaseViewController<DetailsViewModel> {

    @IBOutlet weak var ratesDetailsTblView: UITableView!
    @IBOutlet weak var historyTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        viewModel = DetailsViewModel(historicalUsacase: DetailsUseCase(), latestUsacase: LatestUseCase())
        bindSubscribers()
    }
    
    override func bindSubscribers() {
        super.bindSubscribers()
        
        guard let viewModel = viewModel else {return}
        ratesDetailsTblView.register(cellType: RateTableViewCell.self)
        viewModel.ratesPublisher.bind(to: ratesDetailsTblView.rx.items(cellIdentifier: "RateTableViewCell", cellType: RateTableViewCell.self)){(index, item, cell) in
            cell.setData(model: item)
        }.disposed(by: viewModel.bag)
        
        
        historyTblView.register(cellType: HistoryTableViewCell.self)
        viewModel.historicalRelay.bind(to: historyTblView.rx.items(cellIdentifier: "HistoryTableViewCell", cellType: HistoryTableViewCell.self)){(index, item, cell) in
            cell.setData(model: item)
        }.disposed(by: viewModel.bag)
        
        viewModel.getLatestData(base: viewModel.base ?? "EUR")
    }
}
