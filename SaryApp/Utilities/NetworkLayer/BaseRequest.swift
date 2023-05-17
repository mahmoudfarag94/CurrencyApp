//
//  BaseRequest.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation
import Alamofire

class BaseRequest{
   
    var path:String
    var method:HTTPMethod = .get
    var paramters:[String:Any]? = nil
    var header:HTTPHeaders? = nil
    var encoding:ParameterEncoding
    
    internal init(path: String, method: HTTPMethod = .get, paramters: [String : Any]? = nil, header: [String : String]? = nil) {
        self.path = path
        self.method = method
        self.paramters = paramters
        self.header = HTTPHeaders(header ?? [:])
        switch method {
        case .get:
            encoding = URLEncoding.default
        case.post:
            encoding = JSONEncoding.default
        default:
            encoding = JSONEncoding.default
        }
    }
}
enum HeadersType{
   case  unAuth
    case auth
    
}


class NetworkUtilities{
    
    static func getHeaders()->[String: String]{
        var lang = "en"
//        switch Language.language {
//        case.arabic:
//            lang =  "ar"
//        case.english:
//            lang =  "en"
//        }
        let header: [String: String] = [ "Content-Type": "application/json" ,
                                         "Language": lang ,
                                         "device-type": "2" ,
                                         "device-id": UIDevice.current.identifierForVendor!.uuidString]
        return header
    }
}