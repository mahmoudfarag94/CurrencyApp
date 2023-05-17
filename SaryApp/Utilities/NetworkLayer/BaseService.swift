//
//  BaseService.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//


import Foundation
import Alamofire

class BaseService {
    
    private init(){}
    static let shared = BaseService()
    func performRequest(request: BaseRequest, callbackString: @escaping ((AFDataResponse<String>) -> Void)){
        print("-path-\(request.path)","\n-method-\(request.method),\n-paramters- \(request.paramters) \n-heaaders \(request.header)" )
        AF.request(request.path, method: request.method , parameters: request.paramters, encoding: request.encoding, headers: request.header)
            .responseString {(response) in
                switch response.result{
                case.failure(let error):
                    print("❌ Respons Error Details >>>> " + error.localizedDescription)
                    callbackString(response)
                case .success( _):
                    callbackString(response)
                }
            }
    }
}

