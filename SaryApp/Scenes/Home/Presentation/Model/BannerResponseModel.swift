//
//  BannerResponseModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 21/05/2023.
//

import Foundation

struct BannerModel: Codable{
    
    var image, photo: String?
    
    enum CodingKeys: String, CodingKey{
        case image = "image"
        case photo = "photo"
    }
}

struct BannerResponseModel: GeneralResponsePro{
    var statusCode: Int?
    var status:Bool?
    var message: String?
    var result:[BannerModel]?
    
    enum CodingKeys: String, CodingKey{
        case statusCode = "status_code"
        case status = "status"
        case message = "message"
        case result = "result"
    }
}

