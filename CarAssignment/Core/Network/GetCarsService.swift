//
//  GetCarsService.swift
//  CarAssignment
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import Foundation
import Alamofire

enum CarsServices : URLRequestConvertible {

    case getCars(params: Parameters)
    
    var method: HTTPMethod {
         return .get
    }
    
    var path: String {
        return "/carsonline"
    }
    
    var parameters: Parameters? {
        return nil
    }
    var headers: HTTPHeaders? {
        return nil
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = try ( NetworkManager.baseURL ).asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        if headers != nil {
            urlRequest.allHTTPHeaderFields = headers
        }
        if let params = parameters {
            urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
        }
        return urlRequest
    }
}
