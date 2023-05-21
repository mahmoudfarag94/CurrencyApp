//
//  CatelogModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 19/05/2023.
//

import Foundation

struct CatelogResponseModel: GeneralResponsePro{
    var statusCode: Int?
    var status:Bool?
    var message: String?
    var result:[CatelogModel]?
    
    enum CodingKeys: String, CodingKey{
        case statusCode = "status_code"
        case status = "status"
        case message = "message"
        case result = "result"
    }
}

struct CatelogModel: Codable{
    var id:Int
    var title:String?
    var data:[CatelogDataModel]?
    var uiType:String?
    var showTitle:Bool?
    var dataType:String?
    var rowCount:Int?
   
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case data = "data"
        case uiType = "ui_type"
        case showTitle = "show_title"
        case rowCount = "row_count"
        case dataType = "data_type"
    }
}

struct CatelogDataModel: Codable{
    
    var metadata: MetaDataModel?
    var groupId: Int?
    var groupType, name, image, thumbImg: String?
    var visuals, isMustRefresh: Bool?
    
    enum CodingKeys: String, CodingKey{
        case metadata = "metadata"
        case groupId = "group_id"
        case groupType = "group_type"
        case name = "name"
        case image = "image"
        case thumbImg = "thumb_img"
        case isMustRefresh = "is_must_refresh"
        case visuals = "visuals"
    }
}


struct MetaDataModel: Codable{
    var title: String?
    var subTitle: String?
    var consumableDisplay: String?
    var country: CountryModel?
    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case subTitle = "sub_title"
        case consumableDisplay = "consumable_display"
        case country = "country"
    }
}

struct CountryModel: Codable{
   
    var name: String?
    var code: String?

    enum CodingKeys: String, CodingKey{
        case name = "name"
        case code = "code"
    }
}
