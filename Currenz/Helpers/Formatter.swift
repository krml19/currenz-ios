//
//  Formatter.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

class FormatterHelper {
    
    static let shared = FormatterHelper()
    
    private let numberFormatter: NumberFormatter
    
    private init() {
        numberFormatter = NumberFormatter()
        numberFormatter.minimum  = 0
        numberFormatter.maximum = 1000000
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
    }
    
    func number(from: String) -> Decimal? {
        return numberFormatter.number(from: from)?.decimalValue
    }
    
    func string(from: Decimal) -> String? {
        return numberFormatter.string(from: from as NSDecimalNumber)
    }
    
    func noCurrency() -> String {
        return "---"
    }
}
