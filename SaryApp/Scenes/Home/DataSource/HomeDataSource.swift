//
//  HomeDataSource.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 03/06/2023.
//

import Foundation

class HomeDataSource{
    
    func getAllCatalog<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.catalog.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
    
    func getBanner<T>(completion: @escaping Response<T>) where T  : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.banners.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
}
