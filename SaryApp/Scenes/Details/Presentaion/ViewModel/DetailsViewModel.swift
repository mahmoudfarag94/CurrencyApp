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
    var ratesPublisher = PublishSubject<[RateModel]>()
    
    var historicalUsacase: DetailsUseCase
    var latestUsacase: LatestUseCase
    
    init(historicalUsacase: DetailsUseCase, latestUsacase :LatestUseCase) {
        self.historicalUsacase = historicalUsacase
        self.latestUsacase = latestUsacase
        super.init()
        getHistoricalData()
    }
    
    func getHistoricalData(date: String = "2023-06-01"){
        loaderRelay.accept(true)
        historicalUsacase.getHistorical(date: date) {[weak self] res in
            switch res{
                case .failure(let error):
                print(error)
            case .success(let model):
                print("the Historical model" , model)
                guard  model.error == nil else {
                    print("the error message" , model.error?.errors?.type ?? "")
                    self?.errorRelay.accept(BaseError.statusCode(model.error?.errors?.type ?? ""))
                    self?.loaderRelay.accept(false)
                    return
                }
                self?.historicalRelay.accept(model.rates?.rates ?? [])
                self?.loaderRelay.accept(false)
            }
        }
    }
    
    func getLatestData(base: String?){
        loaderRelay.accept(true)
        latestUsacase.getLatest(base: base ?? "EUR"){[weak self] res in
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
                self?.ratesPublisher.onNext(model.rates?.rates ?? [])
                self?.loaderRelay.accept(false)
            }
        }
    }
}

extension Date{
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    func getPreviousDate(value:Int)->Date{
       return Calendar.current.date(byAdding: .day, value: -value, to: self)!
    }
}
