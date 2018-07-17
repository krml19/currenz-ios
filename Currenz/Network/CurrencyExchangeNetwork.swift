//
//  CurrencyExchangeNetwork.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import Moya

protocol CurrencyExchangeServiceType: class {
    func rate(currencyExchangeSymbol: String) -> Single<[CurrencyExchangeModel]>
}

class CurrencyExchangeSerivce: CurrencyExchangeServiceType {
    func rate(currencyExchangeSymbol: String) ->  Single<[CurrencyExchangeModel]> {
        return provider.rx
            .request(.rate(currencyExchangeSymbol))
            .map(Array<CurrencyExchangeModel>.self)
    }
}
