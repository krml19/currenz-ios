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
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        super.init()
        transform()
    }
}

// MARK: - Preparation
fileprivate extension CurrencyExchangeViewModel {
    func transform() {
        input.currencyExchangeSymbol
            .filterNil()
            .flatMapLatest { (currencySymbol) -> Observable<CurrencyExchangeModel?> in
                return self.dependencies.currencyExchangeService.rate(currencyExchangeSymbol: currencySymbol).asObservable()
            }
            .bind(to: output.currencyExchange)
            .disposed(by: disposeBag)
        
    }
}

extension CurrencyExchangeViewModel {
    struct Dependencies {
        let currencyExchangeService: CurrencyExchangeSerivce
    }
}

// MARK: - Input
extension CurrencyExchangeViewModel {
    struct Input {
        let currencyExchangeSymbol: BehaviorSubject<String?> = BehaviorSubject<String?>(value: nil)
    }
}

// MARK: - Output
extension CurrencyExchangeViewModel {
    struct Output {
        let title = Driver<String>.just(R.string.localizable.currency_exchange_title())
        let currencyExchange = BehaviorSubject<CurrencyExchangeModel?>(value: nil)
    }
}
