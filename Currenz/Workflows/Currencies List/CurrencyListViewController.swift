//  
//  CurrencyListViewController.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

protocol CurrencyListViewControllerDelegate: class {
    func didCancel()
    func didSelect(currencyExchangeCode: String)
}

final class CurrencyListViewController: ViewController {

    // MARK: Properties
    var viewModel: CurrencyListViewModel!
    weak var delegate: CurrencyListViewControllerDelegate?
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.register(cellType: CurrencyTableViewCell.self)
        let dataSource = RxTableViewSectionedReloadDataSource<CurrencyListViewModel.CurrencySectionModel>(configureCell: { (ds, tv, indexPath, item) -> UITableViewCell in
            let cell: CurrencyTableViewCell = tv.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: item)
            return cell
        })
        viewModel.output.items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.modelSelected(CurrencyCellViewModel.self).asObservable()
            .subscribe(onNext: { (selectedModel) in
                log.info(selectedModel.model)
            }).disposed(by: disposeBag)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.rx.text.asObservable().bind(to: viewModel.input.inputQuery).disposed(by: disposeBag)
    }
}

// MARK: - ViewModelBinder
extension CurrencyListViewController: ViewModelBinder {
    typealias ViewModelType = CurrencyListViewModel
    
    func bindViewModel(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
    }
}
