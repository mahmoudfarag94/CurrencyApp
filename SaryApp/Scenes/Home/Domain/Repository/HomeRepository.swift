//
//  CatalogRepository.swift
//  SaryApp
//
//  Created by Mahmoud Farag on 19/05/2023.
//

import Foundation
import Alamofire

protocol HomeRepositoryPro{
    func getAllCatalog<E: GeneralResponsePro>( completion: @escaping Response<E>)
    func getBanner<E: GeneralResponsePro>( completion: @escaping Response<E>)
}

class HomeRepository: HomeRepositoryPro{
    
    func getAllCatalog<E>(completion: @escaping Response<E>) where E : GeneralResponsePro {
        let req = BaseRequest(path: WebServices.catalog.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
    
    func getBanner<E>(completion: @escaping Response<E>) where E : GeneralResponsePro {
        let req = BaseRequest(path: WebServices.banners.getEndPoint())
        GenaricService.shared.request(request: req, completion: completion)
    }
}
