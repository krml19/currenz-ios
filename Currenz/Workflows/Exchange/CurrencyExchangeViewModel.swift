//  
//  CurrencyExchangeViewModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import RxCocoa

final class CurrencyExchangeViewModel: ViewModel {
//    let input = Input()
    let output = Output()
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - Preparation
fileprivate extension CurrencyExchangeViewModel {
//    func transform(_ input: Input) -> Output {
//        input.currencyExchangeSymbol
//            .subscribe(onNext: { [weak self] (currencyExchangeSymbol) in
//                self?.dependencies.currencyExchangeService.rate()
//            }).disposed(by: disposeBag)
//    }
}

extension CurrencyExchangeViewModel {
    struct Dependencies {
        let currencyExchangeService: CurrencyExchangeSerivce
    }
}

// MARK: - Input
extension CurrencyExchangeViewModel {
    struct Input {
        let currencyExchangeSymbol: Observable<String>
    }
}

// MARK: - Output
extension CurrencyExchangeViewModel {
    struct Output {
        let title = Driver<String>.just(R.string.localizable.currency_exchange_title())
    }
}
