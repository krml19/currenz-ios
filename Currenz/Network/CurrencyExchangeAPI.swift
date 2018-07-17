//
//  CurrencyExchangeAPI.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Moya
import Alamofire

let provider = MoyaProvider<CurrencyExchange>(
    plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: BasicAPI.JSONResponseDataFormatter)]
)

public enum CurrencyExchange {
    case rate(String)
}

extension CurrencyExchange: TargetType {
    public var baseURL: URL { return URL(string: Constants.API.forex.rawValue)!  }

    public var path: String {
        switch self {
        default:
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
//        GET https://forex.1forge.com/1.0.3/quotes?pairs=EURUSD,GBPJPY,AUDUSD&api_key=5FUtehFHXcw1xCIj2rbI5uNacWNDDMM1
        switch self {
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
