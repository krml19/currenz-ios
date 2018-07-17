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
    let symbol: String
    let name: String
}
