//
//  HomeRouter.swift
//  AGMVVM
//
//  Created by ahmed gado on 04/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation
import Alamofire
enum NetworkManager: URLRequestBuilder {
    
    case gethomeDetails
    // MARK: - Path
    internal var path: String {
        switch self {
        case .gethomeDetails:
            return ApiUrl.homeRequest
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        let params = Parameters.init()
        switch self {
        case .gethomeDetails: break
        }
        return params
    }
    // MARK: - Header
    internal  var headers: HTTPHeaders {
        let header = HTTPHeaders()
        return header
    }
    // MARK: - Methods
    internal var method: HTTPMethod {
        return .get
    }
    
}

