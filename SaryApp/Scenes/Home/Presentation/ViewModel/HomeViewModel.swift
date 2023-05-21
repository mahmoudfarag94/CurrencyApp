//
//  HomeViewModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 18/05/2023.
//

import Foundation
import RxSwift
import RxDataSources
import RxRelay



enum DataType: String{
    case banner = "banner"
}


class HomeViewModel: BaseViewModel{
    
    var catalogItems = PublishSubject<[SectionModel<String, CatelogModel>]>()
    var bannerItems = BehaviorRelay<[BannerModel]>(value: [])
    private let dispatchGroup = DispatchGroup()
    
    var catalogUC: FetchCatelogUseCase
    var bannerUC: FetchBannerUseCase
    init(catalogUC: FetchCatelogUseCase , bannerUC: FetchBannerUseCase) {
        self.catalogUC = catalogUC
        self.bannerUC = bannerUC
        
        super.init()
        getHomeData()
        getBannerData()
        self.dispatchGroup.notify(queue: .main) {
            self.loaderRelay.accept(false)
        }
    }
    
    func getHomeData(){
        dispatchGroup.enter()
        loaderRelay.accept(true)
        catalogUC.getHomeData {[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print(model)
                let data = model.result?.filter{$0.dataType == DataType.banner.rawValue}
                let banner = data?.map{SectionModel(model: $0.title ?? "", items: [$0])}
                self?.catalogItems.onNext(banner ?? [])
                self?.loaderRelay.accept(false)
            }
            self?.dispatchGroup.leave()
        }
    }
    
    func getBannerData(){
        dispatchGroup.enter()
        loaderRelay.accept(true)
        bannerUC.getBannerData {[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print(model)
                self?.bannerItems.accept(model.result ?? [])
                
            }
            self?.dispatchGroup.leave()
        }
    }
}

























