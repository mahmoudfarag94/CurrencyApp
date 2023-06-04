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
    var rates: RatesResponseModel?
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
