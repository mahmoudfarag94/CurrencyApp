//
//  EnviromentType.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation

enum EnviromentType{
    
    case production
    case debuging
    
     static var current: EnviromentType{
        #if DEBUG
        return .debuging
        #else
        return .production
        #endif
    }

    private func getEnviroment()->String{
        switch EnviromentType.current {
        case .production:
            return "https://staging.sary.to/api/baskets/328594/"
        case .debuging:
            return "https://staging.sary.to/api/baskets/328594/"
        }
    }
    
    static var baseUrl: String{
        return EnviromentType.current.getEnviroment()
    }
}

//MARK: -

enum WebServices: String{
    
    //MARK: - Home .
    case banners = "banners"
    case catalog = "catalog"
    
    func getEndPoint() -> String{
        let base = EnviromentType.baseUrl
        print("base url - ---- \(base)")
        switch self {
        case .catalog:
            return "\(String(describing: base))\(rawValue)/"
        case .banners:
            return "\(String(describing: base))\(rawValue)/"
        }
    }
}


