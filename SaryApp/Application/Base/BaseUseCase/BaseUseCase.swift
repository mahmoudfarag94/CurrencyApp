//
//  BaseUseCase.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation
//protocol BaseUseCasePro{
//    func execute<T: Codable>(model: T, handler: @escaping(_ model: Codable?, _ error: BaseError?)->Void)
//}
//
//class BaseUseCase: BaseUseCasePro{
//    func execute<T>(model: T, handler: @escaping (Codable?, BaseError?) -> Void) where T : Decodable, T : Encodable {}
//}
//

protocol BaseUseCasePro{
    func execute<T: Codable>(requestModel: T?, handler: @escaping((_ value: GeneralResponsePro?, _ error: Error?)->Void))
    
    // dont forget add general validation func.
}

class BaseUseCase: BaseUseCasePro{
    
    func execute<T>(requestModel: T?, handler: @escaping ((GeneralResponsePro?, Error?) -> Void)) where T : Decodable, T : Encodable {}
}
