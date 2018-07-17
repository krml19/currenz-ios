//  
//  CurrencyListViewController.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift

protocol CurrencyListViewControllerDelegate: class {
    func didCancel()
    func didSelect(currencyExchangeCode: String)
}

final class CurrencyListViewController: ViewController {

    // MARK: Properties
    var viewModel: CurrencyListViewModel!
    weak var delegate: CurrencyListViewControllerDelegate?
    @IBOutlet weak var closeButton: UIBarButtonItem!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(viewModel != nil, "Oooups, viewModel property not instantiated.")
        
        prepareViewController()
    }
}

// MARK: - Preparation
private extension CurrencyListViewController {
    func prepareViewController() {
        closeButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] (_) in
                self?.delegate?.didCancel()
            }).disposed(by: disposeBag)
    }
}

// MARK: - ViewModelBinder
extension CurrencyListViewController: ViewModelBinder {
    typealias ViewModelType = CurrencyListViewModel
    
    func bindViewModel(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
    }
}
