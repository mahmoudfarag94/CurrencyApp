//
//  BaseResponseModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation
protocol GeneralResponsePro: Decodable{
    var message:String?{get set}
    var statusCode:Int?{get set}
}

class BaseResponseModel: GeneralResponsePro{
    var statusCode: Int?
    var message: String?
    
    enum CodingKeys: String , CodingKey {
        case statusCode = "status_code"
        case message
    }
}



