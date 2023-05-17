//
//  BaseError.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation

enum BaseError: Error{
    
    case noInternet(String)
    case validation(String)
    case custom(Error)
    case statusCode(String)
    
    func getErrorType()->String{
        switch self{
        case.custom(let erorr):
            return erorr.localizedDescription
        case .noInternet(let internetError):
            return internetError
        case .validation(let validationError):
            return validationError
        case .statusCode(let statusCodeError):
            return statusCodeError
        }
    }
}



