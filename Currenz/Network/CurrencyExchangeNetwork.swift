//
//  CurrencyExchangeNetwork.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import Moya
import RxSwiftExt
import RxOptional
import RxCocoa

protocol CurrencyServiceType: class {
    func currencies() -> Single<[CurrencyModel]>
    func exchange(from: String, to: String) -> Single<CurrencyRateModel>
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
    
    func currencies() -> Single<[CurrencyModel]> {
        return provider.rx
            .request(.currencies)
            .map([String: CurrencyModel].self, atKeyPath: "results")
            .map({Array($0.values)})
    }
    
    func exchange(from: String, to: String) -> Single<CurrencyRateModel> {
        return provider.rx
            .request(.exchange(from: from, to: to))
            .map([String: Decimal].self)
            .map({ (dict) -> CurrencyRateModel? in
                guard let price = dict["\(from)_\(to)"] else { return nil}
                return CurrencyRateModel(from: from, to: to, rate: price)
            })
            // TODO (MK): Add extension for Single in RxOptional
            .asObservable()
            .delay(1, scheduler: MainScheduler.instance)
            .errorOnNil(AppError.jsonParsing)
            .asSingle()
    }
}
