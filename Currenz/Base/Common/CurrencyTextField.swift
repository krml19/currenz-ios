//
//  CurrencyTextField.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class CurrencyTextField: UITextField {
    var bottomLineTextColor: UIColor = UIColor.flatForestGreenColorDark()
    var bottomLinePlaceholderColor: UIColor = UIColor.flatWhiteColorDark()
    
    private let disposeBag = DisposeBag()
    
    private let bottomLineLayer: CALayer = {
        let layer = CALayer()
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareComponent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareComponent()
    }
    
    private func prepareComponent() {
        self.layer.addSublayer(bottomLineLayer)
        self.layer.masksToBounds = true
        delegate = self
        rx.text
            .map({$0.isNotEmpty})
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] (hasText) in
                guard let strongSelf = self else { return }
                strongSelf.bottomLineLayer.borderColor = (hasText ? strongSelf.bottomLineTextColor : strongSelf.bottomLinePlaceholderColor).cgColor
            }).disposed(by: disposeBag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomLineLayer()
    }
    
    private func updateBottomLineLayer() {
        let width = bottomLineLayer.borderWidth
        bottomLineLayer.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
    }
}

// MARK: - UITextFieldDelegate
extension CurrencyTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            return ValidationHelper.numberFormat(text: text + string) == .valid
        }
        return true
    }
}
