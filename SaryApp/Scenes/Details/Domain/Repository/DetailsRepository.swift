//
//  DetailsRepository.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import Foundation
import Alamofire

protocol DetailsRepositoryPro{
    associatedtype T
    func getHistorical<T>( completion: @escaping Response<T>)
    func getLatest<T>( completion: @escaping Response<T>)
}

class DetailsRepository: DetailsRepositoryPro{
    
    typealias T = GeneralResponsePro
    
    var dataSource: DetailsDataSource
    init(dataSource: DetailsDataSource) {
        self.dataSource = dataSource
    }
    
    func getHistorical<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        dataSource.getHistorical(completion: completion)
    }
    
    func getLatest<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        dataSource.getLatest(completion: completion)
    }
}

