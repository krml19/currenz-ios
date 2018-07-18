//
//  CurrencyExchangeAPI.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Moya
import Alamofire

public enum CurrencyAPI {
    case rate(String)
    case currencies
}

extension CurrencyAPI: TargetType {
    public var baseURL: URL {
        switch self {
        case .currencies:
            return URL(string: "https://free.currencyconverterapi.com/api/v6")!
        default:
            return URL(string: Constants.API.forex.rawValue)!
        }
    }

    public var path: String {
        switch self {
        case .currencies:
            return "/currencies"
        case .rate:
            return "/quotes"
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
        case .rate(let symbol):
            let params: [String: Any] = ["pairs": symbol,
                                         "api_key": Constants.Keys.forex.rawValue]
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
