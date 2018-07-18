//
//  CurrencyModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

struct CurrencyModel: Decodable {
    let code: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "currencyName"
        case code = "id"
    }
}

// MARK: - CustomStringConvertible
extension CurrencyModel: CustomStringConvertible {
    var description: String {
        return "\(code): \(name)"
    }
}
