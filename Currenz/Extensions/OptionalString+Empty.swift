//
//  OptionalString+Empty.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        switch self {
        case .some(let wrapped):
            return wrapped.isEmpty
        case .none:
            return true
        }
    }
    
    var isNotEmpty: Bool {
        switch self {
        case .some(let wrapped):
            return wrapped.isNotEmpty
        case .none:
            return false
        }
    }
}
