//
//  BaseResponseModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation
protocol GeneralResponsePro: Codable{
    var message:String?{get set}
    var statusCode:Int?{get set}
    var status:Bool?{get set}
}

class BaseResponseModel: GeneralResponsePro{
    var statusCode: Int?
    var message: String?
    var status:Bool?
    
    enum CodingKeys: String , CodingKey {
        case statusCode = "status_code"
        case message
        case status
    }
}



