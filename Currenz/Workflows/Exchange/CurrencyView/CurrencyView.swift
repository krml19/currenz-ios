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
    @IBOutlet internal weak var emptyView: UIButton!
    
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
        dataModel.currencyModel.map({$0 != nil}).bind(to: emptyView.rx.isHidden).disposed(by: disposeBag)
        emptyView.rx.tap.bind(to: actions.selectAction).disposed(by: disposeBag)
        
        dataModel.titleForEmptyView.bind(to: emptyView.rx.title()).disposed(by: disposeBag)
    }
    
    func configure() {
        currencyValueTextField.rx.text
            .bind(to: dataModel.currencyValue).disposed(by: disposeBag)
        
        dataModel.currencyValue.asObservable()
            .bind(to: currencyValueTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        backgroundColor = .flatWhite()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        backgroundColor = .white
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        backgroundColor = .white
    }
}

// MARK: - Structs
extension CurrencyView {
    struct DataModel {
        let currencyModel = BehaviorSubject<CurrencyModel?>(value: nil)
        let currencyValue = Variable<String?>(nil)
        let titleForEmptyView = Observable<String?>.just(R.string.localizable.select_new_currency())
    }
    
    struct Actions {
        let selectAction = PublishSubject<Void>()
    }
}
