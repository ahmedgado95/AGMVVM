//
//  APIRequestHandler.swift
//  AGMVVM
//
//  Created by ahmed gado on 03/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation
import Alamofire

/// Response completion handler beautified.
typealias CallResponse<T> = ((Result<T, Error>) -> Void)?


/// API protocol, The alamofire wrapper
protocol APIRequestHandler: HandleAlamoResponse { }

extension APIRequestHandler where Self: URLRequestBuilder {

    func send<T: CodableInit>(_ decoder: T.Type, data: [UploadData]? = nil, progress: ((Progress) -> Void)? = nil, then: CallResponse<T>) {
        if let data = data {
            uploadToServerWith(decoder, data: data, request: self, parameters: self.parameters, progress: progress, then: then)
        }else{
            AF.request(self).validate().responseData {(response) in
                self.handleResponse(response, completion: then)
            }.responseJSON { (response) in
                    // handle debug
                print(response.value as Any)
            }
        }
    }
    func cancelRequest() -> Void {
        let sessionManager = Session.default
        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
            uploadTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
            downloadTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
        }
    }
}


extension APIRequestHandler {
    
    private func uploadToServerWith<T: CodableInit>(_ decoder: T.Type, data: [UploadData], request: URLRequestConvertible, parameters: Parameters?, progress: ((Progress) -> Void)?, then: CallResponse<T>) {
        
        AF.upload(multipartFormData: { mul in
            for d in data{
                 mul.append(d.data, withName: d.name, fileName: d.fileName, mimeType: d.mimeType)
            }
            guard let parameters = parameters else { return }
            for (key, value) in parameters {
                mul.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, with: request).responseData { results in
            self.handleResponse(results, completion: then)
        }.responseString { string in
            debugPrint(string.value as Any)
        }
    }
}






