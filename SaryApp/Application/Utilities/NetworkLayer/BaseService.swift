//
//  BaseService.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//


import Foundation
import Alamofire


enum NetworkResponse {
    case success(Data)
    case failure(Error)
}


class BaseNetworkService {
    
    private init(){}
    static let shared = BaseNetworkService()
    
    func performRequest(request: BaseRequest ,completion: @escaping (NetworkResponse) -> Void) {
        
        NetworkLogger("""
            🙇‍♂️ \(request.path):
            📝 Request headers = \(request.header ?? ["header": "No Headers"])
            📝 Request Body = \(request.paramters ?? ["paramters": "No Parameters"])
            """ )
        
        AF.request(request.path, method: request.method,
                   parameters: request.paramters,
                   headers: nil)
        .responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                completion(.success(data))
                
                NetworkLogger("""
                                        ✅ Response: \(response.request?.httpMethod?.uppercased() ?? "") '\(request.path)':
                                        🧾 Status Code: \(response.response?.statusCode ?? 0), \(response.result), 💾 \(data),
                                        ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                                        ⬇️ Response Body = \(String(data: data, encoding: String.Encoding.utf8) ?? "")
                                        """ )
                
            case .failure(let error):
                completion(.failure(error))
                NetworkLogger("""
                                    ❌ Error in response: \(response.request?.httpMethod?.uppercased() ?? "") '\(request.path)' (\(response.response?.statusCode ?? 0), \(response.result)):
                                    ❌ Error: \(error)
                                    ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                                    """)
            }
        }
    }
}
