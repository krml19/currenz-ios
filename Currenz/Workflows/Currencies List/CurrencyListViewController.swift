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

final class CurrencyListViewController: ViewController {

    // MARK: Properties
    var viewModel: CurrencyListViewModel!
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
        
        viewModel.output.title.bind(to: rx.title).disposed(by: disposeBag)
        closeButton.rx.tap.bind(to: viewModel.coordinatorActions.cancelAction).disposed(by: disposeBag)
        
        tableView.configure(registerCells: [CurrencyTableViewCell.self])
        let dataSource = RxTableViewSectionedReloadDataSource<CurrencyListViewModel.CurrencySectionModel>(configureCell: { (ds, tv, indexPath, item) -> UITableViewCell in
            let cell: CurrencyTableViewCell = tv.dequeueReusableCell(for: indexPath)
            cell.configure(viewModel: item)
            return cell
        })
        
        viewModel.output.items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        tableView.rx.modelSelected(CurrencyCellViewModel.self).asObservable()
            .map({$0.model})
            .bind(to: viewModel.coordinatorActions.selectModelAction)
            .disposed(by: disposeBag)
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
