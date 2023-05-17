//
//  GenaricService.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation

class GenaricService{
    
    static let shared = GenaricService()
    private init(){}
    typealias HandlerResponse<T: GeneralResponsePro> = ((_ result: T? ,_ error: BaseError? ,_ statusCode: Int) -> ())
    
    func genariceAPI<T: GeneralResponsePro>(request: BaseRequest, completion: @escaping HandlerResponse<T>){
        BaseService.shared.performRequest(request: request) { response in
            
            switch response.result {
            case .success(_):
                do{
                    print(response)
                    if let data = response.value?.data(using: .utf8){
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(T.self, from: data)
                        print("Response model--===========\(model)")
                        if model.statusCode == 1{
                            completion(model , nil , response.response?.statusCode ?? 1001)
                        }else{
                            completion(model, BaseError.statusCode(model.message ?? ""), response.response?.statusCode ?? 1001)
                        }
                    }
                }catch let error{
                    completion(nil, BaseError.statusCode(error.localizedDescription), response.response?.statusCode ?? 1001)
                }
            case .failure(let error):
                completion(nil, BaseError.statusCode(error.localizedDescription), response.response?.statusCode ?? 1001)
            }
        }
    }
}

