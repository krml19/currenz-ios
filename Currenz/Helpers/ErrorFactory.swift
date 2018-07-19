//
//  ErrorFactory.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

enum AppError: Error {
    case network(error: Error)
    case validation(reason: String)
    case jsonParsing
}

extension AppError: LocalizedError {
    private var errorDescription: String {
        switch self {
        case .validation(let reason):
            return reason
        default:
            return self.localizedDescription
        }
    }
}
