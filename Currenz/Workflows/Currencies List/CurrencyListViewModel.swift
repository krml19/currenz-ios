//  
//  CurrencyListViewModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift
import RxDataSources

struct CurrencyFilters {
    let query: BehaviorSubject<String?>
    let items = Variable<[CurrencyModel]>([])
    
    static private let containsIgnoreCase: (String, String) -> Bool = { code, query in
        return code.lowercased().hasPrefix(query.lowercased())
    }
    
    var filtersItems: Observable<[CurrencyModel]> {
        return Observable.combineLatest(query.asObservable(), items.asObservable()) { (query, it) -> [CurrencyModel] in
            guard let query = query else { return it }
            return it.filter({CurrencyFilters.containsIgnoreCase($0.code, query)})
        }
    }
}

final class CurrencyListViewModel: ViewModel {
    
    let input: Input
    let output: Output
    let coordinatorActions = CoordinatorActions()
    fileprivate let dependencies: Dependencies
    private let filters: CurrencyFilters
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        input = Input.init(inputQuery: BehaviorSubject(value: nil))
        output = Output(items: BehaviorSubject<[CurrencySectionModel]>(value: []))
        filters = CurrencyFilters(query: input.inputQuery)
        super.init()
        
        dependencies.currencyService.currencies().asObservable().bind(to: filters.items).disposed(by: disposeBag)
        
        filters.filtersItems
            .debug("filtersItems", trimOutput: false)
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

// MARK: - CoordinatorActions
extension CurrencyListViewModel {
    struct CoordinatorActions {
        let cancelAction = PublishSubject<Void>()
        let selectModelAction = PublishSubject<CurrencyModel>()
    }
}
