//
//  DetailsUseCase.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 21/05/2023.
//

import Foundation

class DetailsUseCase{
    
    private let repo: any DetailsRepositoryPro
    internal init(repo: any DetailsRepositoryPro = DetailsRepository(dataSource: DetailsDataSource())) {
        self.repo = repo
    }
    
    func getHistorical(date: String ,base: String ,target: String , _ completion: @escaping Response<HistoricalResponseModel>){
        repo.getHistorical(date: date, base: base ,target: target, completion: completion)
    }
}


