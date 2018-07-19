//
//  CurrencyRateModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 19/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

struct CurrencyRateModel {
    let from: String
    let to: String
    let rate: Decimal
}

// MARK: - Factory method
extension CurrencyRateModel {
    static func inversed(currencyRateModel: CurrencyRateModel) -> CurrencyRateModel {
        return CurrencyRateModel(from: currencyRateModel.to, to: currencyRateModel.from, rate: 1 / currencyRateModel.rate)
    }
}
