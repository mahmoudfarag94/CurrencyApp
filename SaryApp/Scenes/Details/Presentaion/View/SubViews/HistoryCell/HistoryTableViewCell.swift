//
//  HistoryTableViewCell.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 06/06/2023.
//
import RxSwift
import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var ratetblView: UITableView!
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    var ratesPublisher = PublishSubject<[RateModel]>()
    let bag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        bindTbl()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setData(model: HistoryUIModel){
        dateLbl.text = model.day
        ratesPublisher.onNext(model.rates)
        tblHeight.constant = CGFloat(model.rates.count * 50)
    }
    
    func bindTbl(){
        ratetblView.register(cellType: RateTableViewCell.self)
        ratesPublisher.bind(to: ratetblView.rx.items(cellIdentifier: "RateTableViewCell", cellType: RateTableViewCell.self)){(index, item, cell) in
            cell.setData(model: item)
        }.disposed(by: bag)
    }
}
