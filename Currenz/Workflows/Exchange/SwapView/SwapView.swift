//  
//  SwapView.swift
//  Currenz
//
//  Created by Marcin Karmelita on 19/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

final class SwapView: View, NibOwnerLoadable {

    @IBOutlet private weak var swapButton: LottieButton!
    @IBOutlet private weak var separatorView: UIView!
    
    let dataModel = DataModel()
    let actions = Actions()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareComponent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
        prepareComponent()
    }

    fileprivate func prepareComponent() {
        dataModel.title.bind(to: swapButton.rx.title()).disposed(by: disposeBag)
        dataModel.image.bind(to: swapButton.rx.animationName).disposed(by: disposeBag)
        swapButton.rx.tap.bind(to: actions.swapAction).disposed(by: disposeBag)

        swapButton.borders()
        swapButton.backgroundColor(UIColor.flatWhite(), for: .normal)
        swapButton.backgroundColor(UIColor.flatWhiteColorDark(), for: .highlighted)
        
        separatorView.backgroundColor = UIColor.flatWhiteColorDark()
    }
    
    func setActivityIndicator(activityIndicator: ActivityIndicator) {
        activityIndicator.asObservable().map({!$0}).bind(to: swapButton.rx.isEnabled).disposed(by: disposeBag)
        activityIndicator.drive(onNext: { [weak self] (loading) in
            guard loading else {
                self?.swapButton.stopAnimation()
                return
            }
            self?.swapButton.setTitle(nil, for: .normal)
            self?.swapButton.playAnimation()
        }).disposed(by: disposeBag)
    }
}

// MARK: - Structs
extension SwapView {
    struct DataModel {
        let title = BehaviorSubject<String?>(value: nil)
        let image = BehaviorSubject<String?>(value: "syncing")
    }
    
    struct Actions {
        let swapAction = PublishSubject<Void>()
    }
}
