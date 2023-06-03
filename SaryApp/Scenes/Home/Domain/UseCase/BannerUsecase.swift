//
//  bannerUsecase.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 21/05/2023.
//

import Foundation

class FetchBannerUseCase{
    
    private let repo: any HomeRepositoryPro
    internal init(repo: any HomeRepositoryPro = HomeRepository(dataSource: HomeDataSource())) {
        self.repo = repo
    }
    
    func getBannerData(_ completion: @escaping Response<BannerResponseModel>){
        repo.getBanner(completion: completion)
    }
}


