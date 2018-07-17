//  
//  CurrencyListViewModel.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import RxSwift

final class CurrencyListViewModel: ViewModel {

    var input = Input()
    var output = Output()

    struct Dependencies {

    }
    fileprivate let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init()
        
        prepareInput()
    }
}

// MARK: - Preparation
fileprivate extension CurrencyListViewModel {
    func prepareInput() {
        prepareActionObserver()
    }
    
    func prepareActionObserver() {
        input.viewController.didAction
            .subscribe(onNext: { [weak self] action in
                switch action {
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Input
extension CurrencyListViewModel {
    struct Input {
        var viewController = ViewControllerInput()
    }

    struct ViewControllerInput {
        enum Action {
            
        }
       var didAction = PublishSubject<Action>()
    }
}

// MARK: - Output
extension CurrencyListViewModel {
    struct Output {
        var viewController = ViewControllerOutput()
        var coordinator = CoordinatorOutput()
    }

    struct ViewControllerOutput {

    }

    struct CoordinatorOutput {

    }
}
