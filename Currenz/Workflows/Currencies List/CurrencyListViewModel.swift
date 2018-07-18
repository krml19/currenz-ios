//  
//  CurrencyListViewModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import RxDataSources

final class CurrencyListViewModel: ViewModel {
    
    let input: Input
    let output: Output
    private let items = Variable<[CurrencyModel]>([])
    fileprivate let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        input = Input.init(inputQuery: BehaviorSubject(value: nil))
        output = Output(items: BehaviorSubject<[CurrencySectionModel]>(value: []))
        
        super.init()
        
        dependencies.currencyService.currencies().asObservable().bind(to: items).disposed(by: disposeBag)
        Observable.combineLatest(input.inputQuery.asObservable(), items.asObservable()) { (query, it) -> [CurrencyModel] in
            return it.filter({$0.code.hasPrefix(query ?? "")})
        }
            .map({$0.map(CurrencyCellViewModel.init)})
            .map(CurrencySectionModel.init)
            .map({[$0]})
            .bind(to: output.items).disposed(by: disposeBag)
    }
}

// MARK: - Input
extension CurrencyListViewModel {
    struct Input {
        let inputQuery: BehaviorSubject<String?>
    }
}

// MARK: - Output
extension CurrencyListViewModel {
    struct Output {
        let items: BehaviorSubject<[CurrencySectionModel]>
    }
}

// MARK: - Dependencies
extension CurrencyListViewModel {
    struct Dependencies {
        let currencyService: CurrencyServiceType
    }
}

// MARK: - SectionModelType
extension CurrencyListViewModel {
    struct CurrencySectionModel: SectionModelType {
        var items: [CurrencyCellViewModel]
        
        init(original: CurrencyListViewModel.CurrencySectionModel, items: [CurrencyCellViewModel]) {
            self = original
            self.items = items
        }
        
        init(items: [CurrencyCellViewModel]) {
            self.items = items
        }
    }
}
