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
import Action

protocol CurrencyExchangeViewControllerDelegate: class {
    func changeRates()
}

final class CurrencyExchangeViewController: ViewController {

    // MARK: Properties
    fileprivate var viewModel: CurrencyExchangeViewModel!
    weak var delegate: CurrencyExchangeViewControllerDelegate?
    
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
        changeRatesButton.rx.tap
        .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] _ in
                self?.delegate?.changeRates()
            }).disposed(by: disposeBag)
        
        viewModel.output.title.asObservable().bind(to: self.rx.title).disposed(by: disposeBag)
        Observable<String?>.just("USDEUR").bind(to: viewModel.input.currencyExchangeSymbol).disposed(by: disposeBag)
        viewModel.output.currencyExchange.bind(to: currencyExchangeView.dataModel.currencyExchangeModel).disposed(by: disposeBag)
    }
}

// MARK: - ViewModel
extension CurrencyExchangeViewController: ViewModelBinder {
    typealias ViewModelType = CurrencyExchangeViewModel
    func bindViewModel(viewModel: CurrencyExchangeViewModel) {
        self.viewModel = viewModel
    }
}
