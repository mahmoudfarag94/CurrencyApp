//
//  ModelError.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 17/05/2023.
//

import Foundation
struct ModelError : Codable {
    let status: Bool
    let message: String
}
enum ResponseStatus<T: Codable> {
    case success(T)
    case failure(String)
}

