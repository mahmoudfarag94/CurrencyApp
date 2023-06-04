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
            return "http://data.fixer.io/api/"
        case .debuging:
            return "http://data.fixer.io/api/"
        }
    }
    
    static var baseUrl: String{
        return EnviromentType.current.getEnviroment()
    }
}

//MARK: -

enum WebServices: String{
    //access_key=f6631da0c331764ddbdcda3597133256
    //MARK: - Home .
    case latest = "latest"
    case Historical = "Historical"
    case symbols = "symbols"
    
    func getEndPoint() -> String{
        let base = EnviromentType.baseUrl
        print("base url - ---- \(base)")
        switch self {
        case .Historical:
            return "\(String(describing: base))2023-06-01?access_key=f6631da0c331764ddbdcda3597133256"
        default:
            return "\(String(describing: base))\(rawValue)?access_key=f6631da0c331764ddbdcda3597133256"
       
//        case .timeseries:
//            return "\(String(describing: base))\(rawValue)/"
//        case .symbole:
//            return "\(String(describing: base))\(rawValue)/"
        }
    }
}


