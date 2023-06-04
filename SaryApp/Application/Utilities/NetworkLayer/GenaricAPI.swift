//
//  GenaricService.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation

typealias Response<T: Codable> = (ResponseStatus<T>) -> Void

class GenaricService{
    
    static let shared = GenaricService()
    private init(){}
    
    func request<T: Decodable>(request: BaseRequest, completion: @escaping Response<T>) {
        BaseNetworkService.shared.performRequest(request: request) { (result) in
            switch result {
            case .success(let data):
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    let dictionary = data as? [String: Any]
                    let json = try JSONSerialization.data(withJSONObject: dictionary as Any, options: .prettyPrinted)
//                    let success = dictionary?["status"] as? Bool
//                    guard success ?? false else {
//                        let jsonDecoder = JSONDecoder()
//                        let error = try jsonDecoder.decode(ModelError.self, from: json)
//                        completion(.failure(error.message))
//                        return
//                    }
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(T.self, from: json)
                    completion(.success(model))
                } catch let error {
                    // JSONDecoder failed
                    NetworkLogger("❌ Error in Mapping\n\(request.path)\nError:\n\(error)")
                }
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
}

