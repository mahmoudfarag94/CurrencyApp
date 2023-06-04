//
//  HomeDataSource.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 03/06/2023.
//

import Foundation

class HomeDataSource{
    
    func getSymbols<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.symbols.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
    
    func getBanner<T>(completion: @escaping Response<T>) where T  : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.latest.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
}
