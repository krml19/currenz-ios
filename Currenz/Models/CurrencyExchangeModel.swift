//
//  CurrencyExchangeModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

struct CurrencyExchangeModel: Decodable {
    var symbol: String
    var timestamp: Int
    var price: Decimal
    var bid: Decimal
    var ask: Decimal
    
    var from: String {
        return String(symbol.prefix(3))
    }
    
    var to: String {
        return String(symbol.suffix(3))
    }
}
