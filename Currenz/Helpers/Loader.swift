//
//  Loader.swift
//  Currenz
//
//  Created by Marcin Karmelita on 01/08/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import RxSwift

final class Loader {
    private let activityIndicator: ActivityIndicator
    private let disposeBag = DisposeBag()
    private let activityData: ActivityData
    
    init(activityIndicator: ActivityIndicator, activityData: ActivityData = ActivityData()) {
        self.activityIndicator = activityIndicator
        self.activityData = activityData
        
        bindActivityIndicator()
    }
    
    private func bindActivityIndicator() {
        activityIndicator.drive(onNext: { [weak self] (loading) in
            guard loading, let strongSelf = self else {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                return
            }
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(strongSelf.activityData, nil)
        }).disposed(by: disposeBag)
    }
}
