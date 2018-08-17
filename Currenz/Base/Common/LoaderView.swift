//  
//  LoaderView.swift
//  Currenz
//
//  Created by Marcin Karmelita on 03/08/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import Reusable
import NVActivityIndicatorView
import RxSwift
import Lottie

protocol LoadableView where Self: UIView & NibLoadable {
    func startRunningAnimations()
    func stopRunningAnimations()
    var isAnimating: Bool { get }
}

final class LoaderView: View, NibLoadable {

    @IBOutlet private weak var activityIndicator: LOTAnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.setAnimation(named: "syncing")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareComponent()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareComponent()
    }

    fileprivate func prepareComponent() {
        
    }
}

// MARK: - LoadableView
extension LoaderView: LoadableView {
    func startRunningAnimations() {
        isHidden = false
        activityIndicator.play()
    }
    
    func stopRunningAnimations() {
        isHidden = true
        activityIndicator.stop()
    }
    
    var isAnimating: Bool {
        return activityIndicator.isAnimationPlaying
    }
}
