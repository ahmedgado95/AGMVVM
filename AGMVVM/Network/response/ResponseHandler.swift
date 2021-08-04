//
//  ResponseHandler.swift
//  AGMVVM
//
//  Created by ahmed gado on 03/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation
import Alamofire

protocol HandleAlamoResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - response: response from network request, for now alamofire Data response
    ///   - completion: completing processing the json response, and delivering it in the completion handler
    func handleResponse<T: CodableInit>(_ response: AFDataResponse<Data>, completion: CallResponse<T>)
}

extension HandleAlamoResponse {
    
    func handleResponse<T: CodableInit>(_ response: AFDataResponse<Data>, completion: CallResponse<T>) {
        switch response.result {
        case .failure(let error):
            guard let data = response.data else { return }
            guard let statusCode = response.response?.statusCode else { return }
            switch statusCode {
            case 400..<500:
                do {
                    let messageError = try DefaultResponse(data: data)
                    completion?(.failure(APIError.errorMessage(message: messageError.message ?? "")))
                } catch {
                    completion?(.failure(error))
                }
            default:
                completion?(.failure(error))
        
            }
        case .success(let value):
            do {
                let defaultResponse = try DefaultResponse(data: value)
                if defaultResponse.status == "success" {
                    let modules = try T(data: value)
                    completion?(.success(modules))
                }else {
                    completion?(.failure(APIError.errorMessage(message: defaultResponse.message ?? "")))
                }
            } catch let jsonError {
                print("Status Code is: \(response.response?.statusCode ?? 000000) \(jsonError)")
                completion?(.failure(jsonError))
            }
        }
    }
}

