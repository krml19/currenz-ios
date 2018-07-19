//  
//  CurrencyExchangeViewModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import RxCocoa
import RxOptional

final class CurrencyExchangeViewModel: ViewModel {
    let input = Input()
    let output = Output()
    let coordinatorActions = CoordinatorActions()
    
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        super.init()
        transform()
    }
}

// MARK: - Preparation
private extension CurrencyExchangeViewModel {
    func transform() {
        input.fromModel.bind(to: output.fromModel).disposed(by: disposeBag)
        input.toModel.bind(to: output.toModel).disposed(by: disposeBag)
        
        Observable.combineLatest(input.fromModel.filterNil(), input.toModel.filterNil(), resultSelector: { (from, to) -> (from: String, to: String) in
                return (from.code, to.code)
            })
            .flatMapLatest { (symbols) -> Observable<CurrencyRateModel> in
                return self.dependencies.currencyService.exchange(from: symbols.from, to: symbols.to).asObservable()
            }
            .bind(to: output.currencyRateModel)
            .disposed(by: disposeBag)
    }
}

// MARK: - CoordinatorActions
extension CurrencyExchangeViewModel {
    struct CoordinatorActions {
        let changeFromModel = PublishSubject<CurrencyModel?>()
        let changeToModel = PublishSubject<CurrencyModel?>()
    }
}

// MARK: - Dependencies
extension CurrencyExchangeViewModel {
    struct Dependencies {
        let currencyService: CurrencyServiceType
    }
}

// MARK: - Input
extension CurrencyExchangeViewModel {
    struct Input {
        let fromModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let toModel = BehaviorSubject<CurrencyModel?>(value: nil)
    }
}

// MARK: - Output
extension CurrencyExchangeViewModel {
    struct Output {
        let title = Driver<String>.just(R.string.localizable.currency_exchange_title())
        
        let currencyRateModel = BehaviorSubject<CurrencyRateModel?>(value: nil)
        let fromModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let toModel = BehaviorSubject<CurrencyModel?>(value: nil)
    }
}
