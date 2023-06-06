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
    func getHistorical<T>(date: String, completion: @escaping Response<T>)
    func getLatest<T>(base: String , completion: @escaping Response<T>)
}

class DetailsRepository: DetailsRepositoryPro{
    
    typealias T = GeneralResponsePro
    
    var dataSource: DetailsDataSource
    init(dataSource: DetailsDataSource) {
        self.dataSource = dataSource
    }
    
    func getHistorical<T>(date: String, completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        dataSource.getHistorical(date: date,  completion: completion)
    }
    
    func getLatest<T>(base: String, completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        dataSource.getLatest(base: base , completion: completion)
    }
}

