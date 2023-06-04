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
    
    var usecase: CurrencyUseCase
    init( usecase: CurrencyUseCase) {
        self.usecase = usecase
        super.init()
        getSymbolsData()
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
}

























