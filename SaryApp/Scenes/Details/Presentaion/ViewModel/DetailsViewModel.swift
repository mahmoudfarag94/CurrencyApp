//
//  DetailsViewModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import Foundation
import RxRelay
import RxSwift







class DetailsViewModel: BaseViewModel{
    
    var historicalRelay = BehaviorRelay<[RateModel]>(value: [])
    
    var historicalUsacase: DetailsUseCase
    var latestUsacase: LatestUseCase
    
    init(historicalUsacase: DetailsUseCase, latestUsacase :LatestUseCase) {
        self.historicalUsacase = historicalUsacase
        self.latestUsacase = latestUsacase
        super.init()
        getHistoricalData()
        getLatestData()
    }
    
    func getHistoricalData(){
        loaderRelay.accept(true)
        historicalUsacase.getHistorical {[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print("the Historical model" , model)
                self?.historicalRelay.accept(model.rates?.rates ?? [])
                self?.loaderRelay.accept(false)
            }
        }
    }
    
    func getLatestData(){
        loaderRelay.accept(true)
        latestUsacase.getLatest{[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print("the latest model" , model)
                self?.loaderRelay.accept(false)
            }
        }
    }
}
