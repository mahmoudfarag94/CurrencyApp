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
    var method: HTTPMethod = .get
    var paramters:[String:Any]? = nil
    var header:HTTPHeaders? = nil
    var encoding:ParameterEncoding
    
    internal init(path: String, method: HTTPMethod = .get, paramters: [String: Any]? = nil, header: [String: String]? = nil) {
        self.path = path
        self.method = method
        self.paramters = paramters
        switch method {
        case .get:
            encoding = URLEncoding.default
        case.post:
            encoding = JSONEncoding.default
        default:
            encoding = JSONEncoding.default
        }
        self.header = HTTPHeaders(defualtHeaders.merging(header ?? [:], uniquingKeysWith: { (first, _) in first }))
    }
    
    private var defualtHeaders: [String: String]{
        let lang = "ar"
        let header: [String: String] = ["Authorization": "token eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NDQyOTIsInVzZXJfcGhvbmUiOiIyMDEwNjQ5ODkyNTAifQ.zNhafprWylIawDsPfGjnkxh3icOV-XN-HgMD3uiXaG0",
                                        "App-Version": "7.7.0.0.0" ,
                                        "Accept-Language": lang ,
                                        "Device-Type":"ios"]
        
        

        
        return header
    }
}
