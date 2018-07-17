//  
//  CurrencyExchangeViewController.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CurrencyExchangeViewController: ViewController {

    // MARK: Properties
    var viewModel: CurrencyExchangeViewModel! = CurrencyExchangeViewModel(dependencies: CurrencyExchangeViewModel.Dependencies(currencyExchangeService: CurrencyExchangeSerivce()))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViewController()
    }
}

// MARK: - Preparation
private extension CurrencyExchangeViewController {
    func prepareViewController() {
        viewModel.output.title.asObservable().bind(to: self.rx.title).disposed(by: disposeBag)
    }
}

// MARK: - ViewModel
private extension CurrencyExchangeViewController {
    func setupRxObservers() {
      
    }
}
