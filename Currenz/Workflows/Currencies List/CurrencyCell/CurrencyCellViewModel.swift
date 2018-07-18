//
//  CurrencyCellViewModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift

final class CurrencyCellViewModel: ViewModel {
    
    let currencyCode: BehaviorSubject<String>
    let currencyName: BehaviorSubject<String>
    let model: CurrencyModel
    
    init(currencyModel: CurrencyModel) {
        self.model = currencyModel
        self.currencyCode = BehaviorSubject<String>(value: currencyModel.code)
        self.currencyName = BehaviorSubject<String>(value: currencyModel.name)
        super.init()
    }
}
