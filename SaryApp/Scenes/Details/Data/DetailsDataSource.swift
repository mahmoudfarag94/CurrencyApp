//
//  DetailsDataSource.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import Foundation

class DetailsDataSource{
    func getHistorical<T>(date: String, base: String ,target: String, completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let path =  WebServices.Historical.getEndPoint() + "\(date)?access_key=6ebfbbddb52f723dfce41168817eef3d&base=\(base)&symbols=\(target)"
        print("the path \(path)")
        let req = BaseRequest(path: path)
        GenaricService.shared.request(request: req, completion: completion)
    }
    
    func getLatest<T>(base: String , completion: @escaping Response<T>) where T : Decodable, T : Encodable {
        let req = BaseRequest(path: "\(WebServices.latest.getEndPoint())&base=\(base)")
        GenaricService.shared.request(request: req, completion: completion)
    }
}
