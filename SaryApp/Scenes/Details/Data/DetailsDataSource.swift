//
//  DetailsDataSource.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import Foundation

class DetailsDataSource{
    
    func getHistorical<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.Historical.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
    
    func getLatest<T>(completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let req = BaseRequest(path: WebServices.latest.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
}
