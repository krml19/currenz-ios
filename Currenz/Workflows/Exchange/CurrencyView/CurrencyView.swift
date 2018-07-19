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

class CurrencyView: View, NibOwnerLoadable {
    
    let dataModel = DataModel()
    let actions = Actions()
    
    @IBOutlet internal var currencyInfoStackView: UIStackView!
    @IBOutlet internal weak var currencyCodeLabel: UILabel!
    @IBOutlet internal weak var currencyNameLabel: UILabel!
    @IBOutlet internal weak var currencyValueTextField: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        prepareComponent()
        configure()
    }

    func prepareComponent() {
        dataModel.currencyModel.map({$0?.code}).replaceNilWith(FormatterHelper.shared.noCurrency()).bind(to: currencyCodeLabel.rx.text).disposed(by: disposeBag)
        dataModel.currencyModel.map({$0?.name}).replaceNilWith(FormatterHelper.shared.noCurrency()).bind(to: currencyNameLabel.rx.text).disposed(by: disposeBag)
        
        currencyInfoStackView.rx.tapGesture().map({_ in ()}).bind(to: actions.selectAction).disposed(by: disposeBag)
    }
    
    func configure() {
        currencyValueTextField.rx.text
            .bind(to: dataModel.currencyValue).disposed(by: disposeBag)
        
        dataModel.currencyValue.asObservable()
            .bind(to: currencyValueTextField.rx.text)
            .disposed(by: disposeBag)
    }
}

// MARK: - Structs
extension CurrencyView {
    struct DataModel {
        let currencyModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let currencyValue = Variable<String?>(nil)
    }
    
    struct Actions {
        let selectAction = PublishSubject<Void>()
    }
}
