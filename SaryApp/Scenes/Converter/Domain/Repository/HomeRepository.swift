//
//  CatalogRepository.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 19/05/2023.
//

import Foundation
import Alamofire

protocol HomeRepositoryPro{
    associatedtype T
    func getSymbols<T>( completion: @escaping Response<T>)
    func getBanner<T>( completion: @escaping Response<T>)
}

class HomeRepository: HomeRepositoryPro{
    
    typealias T = GeneralResponsePro
    
    var dataSource: HomeDataSource
    init(dataSource: HomeDataSource) {
        self.dataSource = dataSource
    }
    
    func getSymbols<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        dataSource.getSymbols(completion: completion)
    }
    
    func getBanner<T>(completion: @escaping Response<T>) where T  : Decodable, T : Encodable {
        dataSource.getBanner(completion: completion)
    }
}

