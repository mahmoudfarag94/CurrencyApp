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
    
    var historicalRelay = BehaviorRelay<[HistoryUIModel]>(value: [])
    var ratesPublisher = PublishSubject<[RateModel]>()
    private var historyData = [HistoryUIModel]()
    private var currentLoop: Int = 1
    var dateValue: Int = 1
    var base = "EUR"
    var target = "EGP"
    var historicalUsacase: DetailsUseCase
    var latestUsacase: LatestUseCase
    
    init(historicalUsacase: DetailsUseCase, latestUsacase :LatestUseCase) {
        self.historicalUsacase = historicalUsacase
        self.latestUsacase = latestUsacase
        super.init()
        getHistoricalData(date: getPreviousDate(value: dateValue), base: base  , target: target )
    }
    
    func getHistoricalData(date: String, base: String ,target: String){
        loaderRelay.accept(true)
        historicalUsacase.getHistorical(date: date, base: base, target: target) {[weak self] res in
            guard let self = self else {return}
            switch res{
                case .failure(let error):
                print(error)
                self.errorRelay.accept(BaseError.statusCode(error))
            case .success(let model):
                print("the Historical model" , model)
                guard  model.error == nil else {
                    print("the error message" , model.error?.errors?.type ?? "")
                    self.errorRelay.accept(BaseError.statusCode(model.error?.errors?.type ?? ""))
                    self.loaderRelay.accept(false)
                    return
                }
                self.historyData.append(HistoryUIModel(day: model.date ?? "", rates: model.rates?.rates ?? []))
                self.historicalRelay.accept(self.historyData)
                self.loaderRelay.accept(false)
                if self.currentLoop  <= 2{
                    self.dateValue += 1

                    self.getHistoricalData(date: self.getPreviousDate(value: self.dateValue) , base: "EUR" , target: "EGP")
                    self.currentLoop += 1
                }
            }
        }
    }
    
    func getPreviousDate(value: Int) -> String{
        if let date = Calendar.current.date(byAdding: .day, value: -value, to: Date()){
            print("Date--------\(date)")
           return formatter(date: date)
        }else {
            return ""
        }
    }
    
    func formatter(date: Date)->String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
       let str = formatter.string(from: date)
        return str
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
                self?.ratesPublisher.onNext(model.rates?.rates?.suffix(10) ?? [])
                self?.loaderRelay.accept(false)
            }
        }
    }
}
