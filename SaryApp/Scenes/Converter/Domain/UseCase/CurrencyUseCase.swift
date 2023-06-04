//
//  CatalogUsecase.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 19/05/2023.
//

import Foundation

class CurrencyUseCase: BaseUseCase{
        
    private let repo: any HomeRepositoryPro
    internal init(repo: any HomeRepositoryPro = HomeRepository(dataSource: HomeDataSource())) {
        self.repo = repo
    }
    
    func getSymbols(_ completion: @escaping Response<CurrencyResponseModel>){
        repo.getSymbols(completion: completion)
    }
}




