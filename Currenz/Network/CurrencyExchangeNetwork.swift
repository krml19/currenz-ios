//
//  CurrencyExchangeNetwork.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import Moya

protocol CurrencyServiceType: class {
    func rate(currencyExchangeSymbol: String) -> Single<CurrencyExchangeModel?>
    func currencies() -> Single<[CurrencyModel]>
    func exchange(from: String, to: String) -> Single<CurrencyModel>
}

class CurrencyService: CurrencyServiceType {
    let provider = MoyaProvider<CurrencyAPI>(
        plugins: [
            NetworkLoggerPlugin(verbose: true, responseDataFormatter: BasicAPI.JSONResponseDataFormatter),
            NetworkActivityPlugin(networkActivityClosure: { (change, _) in
                switch change {
                case .began:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                case .ended:
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
        ]
    )
    
    func rate(currencyExchangeSymbol: String) ->  Single<CurrencyExchangeModel?> {
        return provider.rx
            .request(.rate(currencyExchangeSymbol))
            .map(Array<CurrencyExchangeModel>.self)
            .map({$0.first})
    }
    
    func currencies() -> Single<[CurrencyModel]> {
        return provider.rx
            .request(.currencies)
            .map([String: CurrencyModel].self, atKeyPath: "results")
            .map({Array($0.values)})
    }
    
    func exchange(from: String, to: String) -> Single<CurrencyModel> {
        return provider.rx
            .request(.exchange(from: from, to: to))
            .map([String: Decimal].self)
            .map(<#T##type: Decodable.Protocol##Decodable.Protocol#>)
    }
}
