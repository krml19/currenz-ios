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
import SnapKit

final class Loader {
    private var disposeBag = DisposeBag()
    
    func bind(activityIndicator: ActivityIndicator, loadableView: LoaderView, presentingView: UIView) {
        disposeBag = DisposeBag()
        presentingView.addSubview(loadableView)
        presentingView.bringSubviewToFront(loadableView)
        loadableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        activityIndicator
            .drive(onNext: { [weak loadableView] (loading) in
                loading ? loadableView?.startRunningAnimations() : loadableView?.stopRunningAnimations()
            }).disposed(by: disposeBag)
    }
    
    func bindWindowActivityIndicator(activityIndicator: ActivityIndicator, activityData: ActivityData = ActivityData()) {
        activityIndicator.drive(onNext: { [weak activityData] (loading) in
            guard loading, let activityData = activityData else {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
                return
            }
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
        }).disposed(by: disposeBag)
    }
}
