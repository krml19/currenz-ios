//
//  CurrencyListCoordinator.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
typealias Command<T, U> = (T) -> U

class CurrencyListCoordinator: Coordinator {
    struct Actions {
        let closeAction: Command<Void, Void>
        let selectAction: Command<String, Void>
    }
    
    var actions: Actions?
    func start() {
        guard let currencyListNavigationController = R.storyboard.currencyList.currencyListNavigationController(),
            let currencyListViewController = currencyListNavigationController.topViewController as? CurrencyListViewController
            else {
                fatalError("Wrong kind of UIViewController. Expected: \(CurrencyListViewController.self)")
        }
        let currencyListViewModel = CurrencyListViewModel(dependencies: CurrencyListViewModel.Dependencies(currencyService: CurrencyService()))
        currencyListViewController.bindViewModel(viewModel: currencyListViewModel)
        currencyListViewController.delegate = self
        presentation.present(viewController: currencyListNavigationController)
    }
    
    let presentation: Presentation
    
    required init(presentation: Presentation) {
        self.presentation = presentation
    }
}

// MARK: - CurrencyListViewControllerDelegate
extension CurrencyListCoordinator: CurrencyListViewControllerDelegate {
    func didCancel() {
        actions?.closeAction(())
    }
    
    func didSelect(currencyExchangeCode: String) {
        actions?.selectAction(currencyExchangeCode)
    }
}
