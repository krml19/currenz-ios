//
//  CurrencyExchangeCoordinator.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import Action

class CurrencyExchangeCoordinator: Coordinator {
    enum CoordinatorType {
        case currencyList
    }
    
    fileprivate var childCoordinators: [CoordinatorType: Coordinator] = [:]
    let presentation: Presentation
    
    required init(presentation: Presentation) {
        self.presentation = presentation
    }
    
    func start() {
        guard let currencyExchangeNavigationController = R.storyboard.currencyExchange.instantiateInitialViewController(),
            let currencyExchangeViewController = currencyExchangeNavigationController.topViewController as? CurrencyExchangeViewController else {
                fatalError("Wrong kind of UIViewController. Expected: \(CurrencyExchangeViewController.self)")
        }
        
        let currencyExchangeViewModel = CurrencyExchangeViewModel(dependencies: CurrencyExchangeViewModel.Dependencies(currencyService: CurrencyService()))
        currencyExchangeViewModel.coordinatorActions.changeFromModel.flatMap({self.change(old: $0)}).bind(to: currencyExchangeViewModel.input.fromModel).disposed(by: currencyExchangeViewModel.disposeBag)
        currencyExchangeViewModel.coordinatorActions.changeToModel.flatMap({self.change(old: $0)}).bind(to: currencyExchangeViewModel.input.toModel).disposed(by: currencyExchangeViewModel.disposeBag)
        
        currencyExchangeViewController.bindViewModel(viewModel: currencyExchangeViewModel)
        presentation.present(viewController: currencyExchangeNavigationController)
    }
}

// MARK: - CurrencyExchangeViewModel.CoordinatorActions
private extension CurrencyExchangeCoordinator {
    func change(old: CurrencyModel?) -> Single<CurrencyModel?> {
        return Single<CurrencyModel?>.create { [weak self] (observer) -> Disposable in
            self?.changeRate(from: old, completion: { (selectedCurrencyModel) in
                observer(SingleEvent.success(selectedCurrencyModel))
            })
            return Disposables.create()
        }
    }
    
    func changeRate(from: CurrencyModel?, completion: @escaping Command<CurrencyModel?, Void>) {
        guard let presentingViewController = presentation.presentingViewController else {
            fatalError("Property: `presentation.presentingViewController` cannot be nil")
        }
        let currencyListCoordinator = CurrencyListCoordinator(presentation: .present(viewController: presentingViewController))
        childCoordinators[.currencyList] = currencyListCoordinator
        
        currencyListCoordinator.actions = CurrencyListCoordinator.Actions(closeAction: { [weak self, weak currencyListCoordinator] _ in
            log.debug("close")
            currencyListCoordinator?.stop()
            self?.childCoordinators[.currencyList] = nil
            completion(from)
        }, selectAction: { [weak self, weak currencyListCoordinator] selectedCurrencyModel in
            log.debug("select: \(selectedCurrencyModel)")
            currencyListCoordinator?.stop()
            self?.childCoordinators[.currencyList] = nil
            completion(selectedCurrencyModel)
        })
        
        currencyListCoordinator.start()
    }
}
