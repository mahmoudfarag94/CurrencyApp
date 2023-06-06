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

class CurrencyConverterViewModel: BaseViewModel{
    
    var symbolsPublisher = BehaviorRelay<[SymbolModel]>(value: [])
    var latestRelay = BehaviorRelay<[RateModel]>(value: [])

    var basePublisher = BehaviorRelay<String>(value: "")
    var targetPublisher = BehaviorRelay<String>(value: "")
    
    var fromAmountPublisher = BehaviorRelay<String>(value: "")
    var ToAmountPublisher = BehaviorRelay<String>(value: "")
    
    var usecase: CurrencyUseCase
    var detailsUsecase: LatestUseCase
    init( usecase: CurrencyUseCase, detailsUseCase: LatestUseCase) {
        self.usecase = usecase
        self.detailsUsecase = detailsUseCase
        super.init()
        getSymbolsData()
//        getLatestData()
    }
    
    func getSymbolsData(){
        loaderRelay.accept(true)
        usecase.getSymbols {[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print("the model" , model)
                self?.symbolsPublisher.accept(model.symbols?.sym ?? [])
                self?.loaderRelay.accept(false)
            }
        }
    }
    
    func getLatestData(){
        loaderRelay.accept(true)
        detailsUsecase.getLatest(base: basePublisher.value){[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print("the latest model" , model)
                guard  model.error == nil else {
                    print("the error message" , model.error?.errors?.type ?? "")
                    self?.errorRelay.accept(BaseError.statusCode(model.error?.errors?.type ?? ""))
                    self?.loaderRelay.accept(false)
                    return
                }
                self?.latestRelay.accept(model.rates?.rates ?? [])
                self?.loaderRelay.accept(false)
            }
        }
    }
    
    func calculate()->Double{
        let rate = Double(fromAmountPublisher.value) ?? 0.0
        let baseValue = Double(ToAmountPublisher.value) ?? 0.0
        print("Rate value is \(rate) ===== \(baseValue) ===== \(rate * baseValue)")
        return rate * baseValue
    }
}

























