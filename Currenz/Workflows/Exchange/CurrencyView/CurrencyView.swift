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
import RxGesture

final class CurrencyView: View, NibOwnerLoadable {
    
    struct DataModel {
        let currencyModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let currencyValue = Variable<Decimal?>(nil)
        let active = Variable<Bool>(true)
    }
    
    var dataModel = DataModel()
    let actions = Actions()
    struct Actions {
        let selectAction = PublishSubject<Void>()
    }
    
    @IBOutlet weak var currencyInfoStackView: UIStackView!
    @IBOutlet private weak var currencyCodeLabel: UILabel!
    @IBOutlet private weak var currencyNameLabel: UILabel!
    @IBOutlet private weak var currencyValueTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        prepareComponent()
    }

    fileprivate func prepareComponent() {
        dataModel.currencyModel.map({$0?.code}).replaceNilWith(FormatterHelper.shared.noCurrency()).bind(to: currencyCodeLabel.rx.text).disposed(by: disposeBag)
        dataModel.currencyModel.map({$0?.name}).replaceNilWith(FormatterHelper.shared.noCurrency()).bind(to: currencyNameLabel.rx.text).disposed(by: disposeBag)
        
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
        
        currencyInfoStackView.rx.tapGesture().map({_ in ()}).bind(to: actions.selectAction).disposed(by: disposeBag)
    }
}
