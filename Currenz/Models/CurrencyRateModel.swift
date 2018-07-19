//
//  CurrencyRateModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 19/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

struct CurrencyRateModel: Decodable {
    let from: String
    let to: String
    let rate: Decimal
    let inversed: Decimal
    
//    enum CodingKeys: String, CodingKey {
//        case rate = "currencyName"
//        case code = "id"
//    }
}
