//
//  CurrencyFilters.swift
//  Currenz
//
//  Created by Marcin Karmelita on 02/08/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation
import RxSwift

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
