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
        
        let currencyExchangeViewModel = CurrencyExchangeViewModel(dependencies: CurrencyExchangeViewModel.Dependencies(currencyExchangeService: CurrencyService()))
        currencyExchangeViewController.bindViewModel(viewModel: currencyExchangeViewModel)
        currencyExchangeViewController.delegate = self
        presentation.present(viewController: currencyExchangeNavigationController)
    }
}

// MARK: - CurrencyExchangeViewControllerDelegate
extension CurrencyExchangeCoordinator: CurrencyExchangeViewControllerDelegate {
    func changeRates() {
        guard let presentingViewController = presentation.presentingViewController else {
            fatalError("Property: `presentation.presentingViewController` cannot be nil")
        }
        let currencyListCoordinator = CurrencyListCoordinator(presentation: .present(viewController: presentingViewController))
        childCoordinators[.currencyList] = currencyListCoordinator
        
        currencyListCoordinator.actions = CurrencyListCoordinator.Actions(closeAction: { [weak self, weak currencyListCoordinator] _ in
            log.debug("close")
            currencyListCoordinator?.stop()
            self?.childCoordinators[.currencyList] = nil
        }, selectAction: { [weak self, weak currencyListCoordinator] currencyCode in
            log.debug("select: \(currencyCode)")
            currencyListCoordinator?.stop()
            self?.childCoordinators[.currencyList] = nil
        })
        
        currencyListCoordinator.start()
    }
}
