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
        let currencyRateModel = BehaviorSubject<CurrencyRateModel?>(value: nil)
        let fromModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let toModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let inputValue = BehaviorSubject<Decimal?>(value: nil)
        var outputValue: Observable<Decimal?> {
            return Observable.combineLatest(currencyRateModel, inputValue) { (model, input) -> Decimal? in
                guard let price = model?.rate, let input = input else { return nil }
                return price * input
            }
        }
    }
    
    struct Actions {
        let fromCurrencyTappedAction: PublishSubject<Void>
        let toCurrencyTappedAction: PublishSubject<Void>
    }
    
    let dataModel: DataModel = DataModel()
    var actions: Actions!
    
    @IBOutlet private weak var fromCurrencyView: CurrencyView!
    @IBOutlet private weak var toCurrencyView: CurrencyView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        prepareComponent()
        
    }

    private func prepareComponent() {
        fromCurrencyView.dataModel.currencyValue.asObservable().debug().bind(to: dataModel.inputValue).disposed(by: disposeBag)
        dataModel.outputValue.debug().bind(to: toCurrencyView.dataModel.currencyValue).disposed(by: disposeBag)
        
        dataModel.fromModel.bind(to: fromCurrencyView.dataModel.currencyModel).disposed(by: disposeBag)
        dataModel.toModel.bind(to: toCurrencyView.dataModel.currencyModel).disposed(by: disposeBag)
        
        actions = Actions(fromCurrencyTappedAction: fromCurrencyView.actions.selectAction, toCurrencyTappedAction: toCurrencyView.actions.selectAction)
        
        toCurrencyView.dataModel.active.value = false
    }
}
