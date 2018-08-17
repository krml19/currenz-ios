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
        let swapAction: PublishSubject<Void>
    }
    
    let dataModel: DataModel = DataModel()
    var actions: Actions!
    var activityIndicator: ActivityIndicator? {
        didSet {
            if let activityIndicator = activityIndicator {
                swapView.setActivityIndicator(activityIndicator: activityIndicator)
            }
        }
    }
    @IBOutlet private weak var fromCurrencyView: CurrencyView!
    @IBOutlet private weak var toCurrencyView: CurrencyView!
    @IBOutlet weak var swapView: SwapView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        prepareComponent()
    }

    private func prepareComponent() {
        fromCurrencyView.dataModel.currencyValue.asObservable()
            .map({FormatterHelper.shared.number(from: $0)})
            .debug().bind(to: dataModel.inputValue).disposed(by: disposeBag)
        
        dataModel.outputValue.debug()
            .map({FormatterHelper.shared.string(from: $0)})
            .bind(to: toCurrencyView.dataModel.currencyValue).disposed(by: disposeBag)
        
        dataModel.fromModel.bind(to: fromCurrencyView.dataModel.currencyModel).disposed(by: disposeBag)
        dataModel.toModel.bind(to: toCurrencyView.dataModel.currencyModel).disposed(by: disposeBag)
        
        actions = Actions(fromCurrencyTappedAction: fromCurrencyView.actions.selectAction, toCurrencyTappedAction: toCurrencyView.actions.selectAction, swapAction: swapView.actions.swapAction)
        
        dataModel.currencyRateModel.map({FormatterHelper.shared.string(from: $0?.rate)}).bind(to: swapView.dataModel.title).disposed(by: disposeBag)
    }
}
