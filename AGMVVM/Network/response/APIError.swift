//
//  APIError.swift
//  AGMVVM
//
//  Created by ahmed gado on 03/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation
/// Errors enum, to be sent back to network caller, so he handle it gracefully.
enum APIError:  LocalizedError {
    case errorMessage(message : String)
    var localizedDescription: String  {
        switch self {
        case .errorMessage(let message):
            return message
        }
    }
}
