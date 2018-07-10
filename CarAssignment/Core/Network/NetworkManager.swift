//
//  NetworkAPI.swift
//  Tomato
//
//  Created by Engy Hussein on 7/10/18.
//  Copyright © 2018 Engy Hussein. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkManagerError: String, LocalizedError {
    case parseError = "-100"
    case errorDescription = "invalid_grant"
    
    public var errorDescription: String? {
        switch self {
        case .parseError:
            return ""
        //  return "errorMsg".localized()
        case .errorDescription:
            return "username or password is incorrect"
        }
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}


public class NetworkManager {
    
    public static func request(request: URLRequestConvertible ,completionHandler: @escaping (Result<Any>) -> Void)
    {
        Alamofire.request(request).responseJSON{
            (response: DataResponse<Any>) in
            switch response.result {
            case .success(_):
                if let data = response.result.value as? [String:Any]{
                    if let error = data["Error"] as? [String: Any], !error.isEmpty
                    {
                        completionHandler(Result.failure(NetworkManagerError.parseError))
                    }
                    else
                    {
                        completionHandler(Result.success(data))
                    }
                }
            case .failure(_):
                if let error = response.result.error {
                    completionHandler(Result.failure(error))
                }
            }
        }
    }
}
