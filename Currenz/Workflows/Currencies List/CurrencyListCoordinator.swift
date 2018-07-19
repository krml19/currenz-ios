//
//  CurrencyListCoordinator.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

class CurrencyListCoordinator: Coordinator {
    struct Actions {
        let closeAction: Command<Void, Void>
        let selectAction: Command<CurrencyModel, Void>
    }
    
    var actions: Actions?
    func start() {
        guard let currencyListNavigationController = R.storyboard.currencyList.currencyListNavigationController(),
            let currencyListViewController = currencyListNavigationController.topViewController as? CurrencyListViewController
            else {
                fatalError("Wrong kind of UIViewController. Expected: \(CurrencyListViewController.self)")
        }
        let currencyListViewModel = CurrencyListViewModel(dependencies: CurrencyListViewModel.Dependencies(currencyService: CurrencyService()))
        currencyListViewModel.coordinatorActions.cancelAction.subscribe(onNext: { [weak self] _ in
            self?.actions?.closeAction(())
        }).disposed(by: currencyListViewModel.disposeBag)
        currencyListViewModel.coordinatorActions.selectModelAction.subscribe(onNext: { [weak self] newModel in
            self?.actions?.selectAction(newModel)
        }).disposed(by: currencyListViewModel.disposeBag)
        currencyListViewController.bindViewModel(viewModel: currencyListViewModel)
        presentation.present(viewController: currencyListNavigationController)
    }
    
    let presentation: Presentation
    
    required init(presentation: Presentation) {
        self.presentation = presentation
    }
}
