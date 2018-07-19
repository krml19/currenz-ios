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
    fileprivate var viewModel: CurrencyExchangeViewModel!
    
    @IBOutlet weak var changeRatesButton: UIBarButtonItem!
    @IBOutlet weak var currencyExchangeView: CurrencyExchangeView!
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "Oooups, viewModel property not instantiated.")
        
        prepareViewController()
    }
}

// MARK: - Preparation
private extension CurrencyExchangeViewController {
    func prepareViewController() {
        viewModel.output.title.asObservable().bind(to: self.rx.title).disposed(by: disposeBag)
        
        viewModel.output.currencyRateModel.bind(to: currencyExchangeView.dataModel.currencyRateModel).disposed(by: disposeBag)
        viewModel.output.fromModel.bind(to: currencyExchangeView.dataModel.fromModel).disposed(by: disposeBag)
        viewModel.output.toModel.bind(to: currencyExchangeView.dataModel.toModel).disposed(by: disposeBag)
        
        currencyExchangeView.actions.fromCurrencyTappedAction
            .withLatestFrom(viewModel.output.fromModel)
            .observeOn(MainScheduler.instance)
            .bind(to: viewModel.coordinatorActions.changeFromModel)
            .disposed(by: viewModel.disposeBag)
        
        currencyExchangeView.actions.toCurrencyTappedAction
            .withLatestFrom(viewModel.output.toModel)
            .observeOn(MainScheduler.instance)
            .bind(to: viewModel.coordinatorActions.changeToModel)
            .disposed(by: viewModel.disposeBag)
    }
}

// MARK: - ViewModel
extension CurrencyExchangeViewController: ViewModelBinder {
    typealias ViewModelType = CurrencyExchangeViewModel
    func bindViewModel(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
    }
}
