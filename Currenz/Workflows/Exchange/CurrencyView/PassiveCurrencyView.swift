//
//  PassiveCurrencyView.swift
//  Currenz
//
//  Created by Marcin Karmelita on 19/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

final class PassiveCurrencyView: CurrencyView {
    static var nib: UINib {
        return UINib(nibName: String(describing: CurrencyView.self), bundle: Bundle(for: self))
    }
    
    override func prepareBindings() {
        dataModel.currencyValue.asObservable()
//            .map({ (decimalValue) -> String? in
//                return decimalValue != nil ? FormatterHelper.shared.string(from: decimalValue!) : nil
//            })
            .bind(to: currencyValueTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func prepareComponent() {
        super.prepareComponent()
        
        currencyValueTextField.isEnabled = false
    }
}
