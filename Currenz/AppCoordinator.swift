//
//  AppCoordinator.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    enum CoordinatorType {
        case currencyExchange
    }
    
    fileprivate var childCoordinators: [CoordinatorType: Coordinator] = [:]
    
    let presentation: Presentation
    required init(presentation: Presentation) {
        self.presentation = presentation
    }
    
    func start() {
        let currencyExchangeCoordinator = CurrencyExchangeCoordinator(presentation: presentation)
        childCoordinators[.currencyExchange] = currencyExchangeCoordinator
        currencyExchangeCoordinator.start()
    }
}
