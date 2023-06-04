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
    
    func getHistorical(_ completion: @escaping Response<HistoricalResponseModel>){
        repo.getHistorical(completion: completion)
    }
}


