//  
//  CurrencyTableViewCell.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import Reusable
import RxSwift

final class CurrencyTableViewCell: TableCell<CurrencyCellViewModel> {
    
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    override func configure(viewModel: CurrencyCellViewModel) {
        viewModel.currencyCode.bind(to: currencyCodeLabel.rx.text).disposed(by: disposeBag)
        viewModel.currencyName.bind(to: currencyNameLabel.rx.text).disposed(by: disposeBag)
    }
}
