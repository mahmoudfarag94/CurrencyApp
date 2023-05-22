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
    //E: GeneralResponsePro
    func getAllCatalog<T>( completion: @escaping Response<T>)
    func getBanner<T>( completion: @escaping Response<T>)
}

class HomeRepository: HomeRepositoryPro{
    
    typealias T = GeneralResponsePro
    
    func getAllCatalog<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.catalog.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
    
    func getBanner<T>(completion: @escaping Response<T>) where T  : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.banners.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
}
