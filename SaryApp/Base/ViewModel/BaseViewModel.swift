//
//  BaseViewModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import RxSwift
import RxRelay

class BaseViewModel{
    
    var bag = DisposeBag()
    var loaderRelay = BehaviorRelay<Bool>(value: false)
    var errorRelay = PublishRelay<BaseError>()
    
    
//    init(){
//        guard let useCase = useCase else {return}
//        self.useCase = useCase
//    }
}




