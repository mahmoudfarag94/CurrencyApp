//
//  CatelogModel.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 19/05/2023.
//

import Foundation
import RxSwift

//struct CurrencyModel{
//
//    var country: String
//    var currency: String
//    var ISOCode:String
//
//    init(country: String, currency: String , ISOCode:String) {
//        self.country = country
//        self.currency = currency
//        self.ISOCode = ISOCode
//    }
//}

struct CurrencyResponseModel: GeneralResponsePro{
    var success: Bool?
    var symbols: SymbolsResponseModel?
}

struct SymbolModel: Codable{
    var key:String?
    var value:String?
    init(key: String? = nil, value: String? = nil) {
        self.key = key
        self.value = value
    }
    
}

struct SymbolsResponseModel: Codable{
//    var sym: [[String:String]]?
    var sym: [SymbolModel]?
    
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
//        var tempArray = [[String:String]]()
        var tempArray = [SymbolModel]()

        for key in container.allKeys {
            print("all keys \(key)")
            let decodedObject = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            print("the object decoded" , decodedObject)
//            let item = [key.stringValue : decodedObject]
            let item = SymbolModel(key: key.stringValue , value: decodedObject)
            tempArray.append(item)
        }
        sym = tempArray
    }
}
