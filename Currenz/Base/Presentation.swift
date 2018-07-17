//
//  Presentation.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

enum Presentation {
    case root(window: UIWindow)
    case present(viewController: UIViewController)
    case push(navigationController: UINavigationController)
    
    var presentingViewController: UIViewController? {
        switch self {
        case .present(let viewController):
            return viewController
        case .root(let window):
            let viewController = (window.rootViewController as? UINavigationController)?.topViewController ?? window.rootViewController
            return viewController
        case .push(let navigationController):
            return navigationController.topViewController
        }
    }
    
    func present(viewController: UIViewController) {
        switch self {
        case .present(let presentingViewController):
            presentingViewController.present(viewController, animated: true, completion: nil)
        case .root(let window):
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        case .push(let navigationController):
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func pop() {
        switch self {
        case .root(let window):
            // TODO (MK): How to handle it?
            break
        case .present(let viewController):
            viewController.dismiss(animated: true, completion: nil)
        case .push(let navigationController):
            navigationController.popViewController(animated: true)
        }
    }
}
