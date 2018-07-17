//  
//  CurrencyView.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import Reusable

final class CurrencyView: View, NibOwnerLoadable {
    
    struct DataModel {
        let currencyCode = BehaviorSubject<String?>(value: FormatterHelper.shared.noCurrency())
        let currencyValue = Variable<Decimal?>(nil)
        let active = Variable<Bool>(true)
    }
    
    var dataModel = DataModel()
    
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    @IBOutlet private weak var currencyValueTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        prepareComponent()
    }

    fileprivate func prepareComponent() {
        dataModel.currencyCode.bind(to: currencyCodeLabel.rx.text).disposed(by: disposeBag)
        currencyValueTextField.rx.text
            .map({$0 != nil ? Decimal(string: $0!) : nil})
            .bind(to: dataModel.currencyValue).disposed(by: disposeBag)
        
        dataModel.currencyValue.asObservable()
            .map({ (decimalValue) -> String? in
                return decimalValue != nil ? FormatterHelper.shared.string(from: decimalValue!) : nil
            })
            .bind(to: currencyValueTextField.rx.text)
            .disposed(by: disposeBag)
        dataModel.active.asObservable().bind(to: currencyValueTextField.rx.isEnabled).disposed(by: disposeBag)
        
    }
}
