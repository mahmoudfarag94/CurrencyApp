//
//  HistoricalResponseModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 05/06/2023.
//

import Foundation

struct HistoricalResponseModel: GeneralResponsePro{
    var success: Bool?
    var timestamp:Int?
    var base:String?
    var date:String?
    var rates: RatesResponseModel?
    var error: ErrorsResponseModel?
}

struct RateModel: Codable{
    var key:String?
    var value:Double?
    init(key: String? = nil, value: Double? = nil) {
        self.key = key
        self.value = value
    }
}

struct RatesResponseModel: Codable{
    var rates: [RateModel]?
    
    init(){}
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempArray = [RateModel]()
        for key in container.allKeys {
            print("all keys \(key)")
            let decodedObject = try container.decode(Double.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            print("the object decoded" , decodedObject)
            let item = RateModel(key: key.stringValue , value: decodedObject)
            tempArray.append(item)
        }
        rates = tempArray
    }
}
struct ErrorModel: Codable{
    var code:Int?
    var type:String?
    
    init(code: Int? = nil, type: String? = nil) {
        self.code = code
        self.type = type
    }
}

struct ErrorsResponseModel: Codable{
    var errors: ErrorModel?
    
   
    init(){}
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//        var tempArray = [ErrorModel]()
        for key in container.allKeys {
           
            var object = ""
            if key.stringValue == "type"{
                print("all keys \(key)")
                let decodedObject = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                object = decodedObject
                let item = ErrorModel(code: key.intValue ?? 0, type: object)
                errors = item
            }else{
//                let decodedObject = try container.decode(Int.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
//                object = "\(decodedObject)"
            }
//            print("the object decoded" , object)
//            let item = ErrorModel(code: key.intValue ?? 0, type: "\(object)")
//            tempArray.append(item)
        }
//        errors = tempArray
    }
}



struct HistoryUIModel{
    var day:String
    var rates:[RateModel]
}
