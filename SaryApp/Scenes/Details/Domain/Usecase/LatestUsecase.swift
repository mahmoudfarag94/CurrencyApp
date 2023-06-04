//
//  LatestUsecase.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import Foundation
class LatestUseCase{
    
    private let repo: any DetailsRepositoryPro
    internal init(repo: any DetailsRepositoryPro = DetailsRepository(dataSource: DetailsDataSource())) {
        self.repo = repo
    }
    
    func getLatest(_ completion: @escaping Response<HistoricalResponseModel>){
        repo.getLatest(completion: completion)
    }
}


