//  
//  CurrencyExchangeView.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

final class CurrencyExchangeView: View, NibOwnerLoadable {

    struct DataModel {
        let currencyExchangeModel = BehaviorSubject<CurrencyExchangeModel?>(value: nil)
        let inputValue = BehaviorSubject<Decimal?>(value: nil)
        let outputValue: Observable<Decimal?>
        
        init() {
            outputValue = Observable.combineLatest(currencyExchangeModel, inputValue) { (model, input) -> Decimal? in
                guard let price = model?.price, let input = input else { return nil }
                return price * input
            }
        }
    }
    
    var dataModel: DataModel = DataModel()

    @IBOutlet private weak var fromCurrencyView: CurrencyView!
    @IBOutlet private weak var toCurrencyView: CurrencyView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        prepareComponent()
        
    }

    private func prepareComponent() {
        fromCurrencyView.dataModel.currencyValue.asObservable().debug().bind(to: dataModel.inputValue).disposed(by: disposeBag)
        dataModel.currencyExchangeModel.map({$0?.from}).bind(to: fromCurrencyView.dataModel.currencyCode).disposed(by: disposeBag)
        
        dataModel.outputValue.debug().bind(to: toCurrencyView.dataModel.currencyValue).disposed(by: disposeBag)
        dataModel.currencyExchangeModel.map({$0?.to}).bind(to: toCurrencyView.dataModel.currencyCode).disposed(by: disposeBag)
    }
}
