//
//  ValidationHelper.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation
import RxSwift

class ValidationHelper {
    enum ValidationStatus: Equatable {
        case valid, invalid(AppError)
        
        static func ==(lhs: ValidationStatus, rhs: ValidationStatus) -> Bool {
            switch (lhs, rhs) {
            case (.valid, .valid):
                return true
            case (.invalid(_), .invalid(_)):
                return true
            default:
                return false
            }
        }
    }
    
    class func validateCurrencyExchangeSymbol(text: String) -> ValidationStatus {
        return validate(text: text, pattern: "^[A-Z]{6}$", failingReason: "")
    }
    
    private class func validate(text: String, pattern: String, failingReason: String) -> ValidationStatus {
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let foundMatch = regex.firstMatch(in: text, range: NSRange(location: 0, length: text.count)) != nil
            return foundMatch ? .valid : .invalid(AppError.validation(reason: failingReason))
        } catch {
            log.error(error)
            fatalError("Incorrect regex pattern: \(pattern)")
        }
    }
}
