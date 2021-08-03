//
//  DefaultResponse.swift
//  AGMVVM
//
//  Created by ahmed gado on 03/08/2021.
//  Copyright © 2021 ahmed gado. All rights reserved.
//

import Foundation
// Default response to check for every request since this's how this api works.
struct DefaultResponse: Codable, CodableInit , LocalizedError {
    var status : String
    var msg : String?
}
