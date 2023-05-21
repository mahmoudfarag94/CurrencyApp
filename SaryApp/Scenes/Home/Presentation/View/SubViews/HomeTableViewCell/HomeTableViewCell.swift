//
//  HomeTableViewCell.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 20/05/2023.
//

import UIKit
import RxDataSources
import RxSwift

enum UIType: String{
    case linear = "linear"
    case grid = "grid"
}

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productGridView: UICollectionView!
    
    var publisher = PublishSubject<[CatelogDataModel]>()
    
    var bag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(){
        productGridView.delegate = nil
        productGridView.rx.setDelegate(self).disposed(by: bag)
        productGridView.register(cellType: ProductCollectionViewCell.self)
        publisher.bind(to: productGridView.rx.items(cellIdentifier: ProductCollectionViewCell.identifier, cellType: ProductCollectionViewCell.self)){(index, item, cell) in
            cell.setData(model: item)
        }.disposed(by: bag)
        
    }
    
    func configuration(model: CatelogModel){
        let type = UIType(rawValue: model.uiType ?? "")
        switch type{
        case .grid:
            let data: [CatelogDataModel] = Array(model.data?.prefix((model.rowCount ?? 0) * (model.rowCount ?? 0)) ?? [])
            publisher.onNext(data)
        case .linear:
            let data: [CatelogDataModel] = Array(model.data?.prefix(model.rowCount ?? 0) ?? [])
            publisher.onNext(data)
        default: break
        }
    }
}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = productGridView.frame.size
        return CGSize(width: (size.width - 50) / 3, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
