//
//  HomeViewController.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 19/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


class HomeViewController: BaseViewController<HomeViewModel> {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var catelogTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel(catalogUC: FetchCatelogUseCase(), bannerUC: FetchBannerUseCase())
        bindSubscribers()
    }
    
    override func bindSubscribers(){
      super.bindSubscribers()
        guard let viewModel = viewModel else {return}
        catelogTblView.rx.setDelegate(self).disposed(by: viewModel.bag)
        catelogTblView.register(cellType: HomeTableViewCell.self)
        bannerCollectionView.register(cellType: BannerCollectionViewCell.self)
        bannerCollectionView.delegate = nil
        bannerCollectionView.rx.setDelegate(self).disposed(by: viewModel.bag)

        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CatelogModel>>(
            configureCell: { (dataSource, tableView, indexPath, element) in
                let cell = tableView.dequeueReusableCell(with: HomeTableViewCell.self, for: indexPath)
                cell.configuration(model: element)
                return cell
            },titleForHeaderInSection: { dataSource, sectionIndex in
                if dataSource[sectionIndex].items.first?.showTitle ?? false {
                    return dataSource[sectionIndex].model
                }else {
                    return ""
                }
            }
        )
        let catalog = viewModel.catalogItems.asDriver(onErrorJustReturn: [])
        catalog.drive(catelogTblView.rx.items(dataSource: dataSource)).disposed(by: viewModel.bag)
        
        
        let banner = viewModel.bannerItems.asDriver(onErrorJustReturn: [])
        banner.drive(bannerCollectionView.rx.items(cellIdentifier: BannerCollectionViewCell.identifier, cellType: BannerCollectionViewCell.self)){(index, item, cell) in
            cell.setData(model: item)
        }.disposed(by: viewModel.bag)
        
        bannerCollectionView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            self?.showToast(msg: viewModel.bannerItems.value[index.item].image ?? "")
        }).disposed(by: viewModel.bag)
    }
}


extension HomeViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

    
extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = bannerCollectionView.bounds.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}


