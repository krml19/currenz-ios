//
//  CurrencyAPI.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Moya
import Alamofire

public enum CurrencyAPI {
    case exchange(from: String, to: String)
    case currencies
}

extension CurrencyAPI: TargetType {
    public var baseURL: URL {
        switch self {
        default:
            return URL(string: Constants.API.currencyConverter.rawValue)!
        }
    }

    public var path: String {
        switch self {
        case .currencies:
            return "/currencies"
        case .exchange:
            return "/convert"
        }
    }

    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    public var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }

    public var task: Task {
        switch self {
        case .currencies:
            return Task.requestPlain
        case .exchange(let from, let to):
            let params: [String: Any] = ["q": "\(from)_\(to)",
                                         "compact": "ultra"]
            return Task.requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }

    public var validate: Bool {
        switch self {
        default:
            return false
        }
    }

    public var headers: [String: String]? {
        switch self {
        default:
            return [:]
        }
    }
}
