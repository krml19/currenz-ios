//
//  LottieButton.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/08/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation
import SnapKit
import Lottie
import RxSwift
import RxCocoa

open class LottieButton: UIButton {
    
    public private(set) var animationView: LOTAnimationView?
    
    public var animationName: String? {
        didSet {
            self.animationView?.removeFromSuperview()
            guard let animationName = animationName else { return }
            self.animationView = LOTAnimationView(name: animationName, bundle: Bundle(for: type(of: self)))
            
            if let animationView = self.animationView {
                self.add(animationView)
                animationView.loopAnimation = true
            }
        }
    }
    
    private func add(_ animationView: LOTAnimationView) {
        self.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalTo(self.imageView!)
        }
        animationView.isHidden = true
    }
    
    private func blankImage(for image: UIImage?) -> UIImage? {
        UIGraphicsBeginImageContext(image?.size ?? .zero)
        let blankImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return blankImage
    }
    
    public func playAnimation(withInitialStateImage initialStateImage: UIImage,
                              andFinalStateImage finalStateImage: UIImage) {
        let blankImage = self.blankImage(for: initialStateImage)
        self.setImage(blankImage, for: .normal)
        self.animationView?.isHidden = false
        
        self.animationView?.play(completion: { completed in
            self.setImage(finalStateImage, for: .normal)
            self.animationView?.isHidden = true
            self.animationView?.pause()
            self.animationView?.animationProgress = 0
        })
    }
    
    open func playAnimation() {
        guard let image = self.image(for: .normal) else { return }
        self.playAnimation(withInitialStateImage: image, andFinalStateImage: image)
    }
    
    open func stopAnimation() {
        self.animationView?.stop()
    }
}

extension Reactive where Base: LottieButton {
    
    /// Reactive wrapper for `animationName`
    public var animationName: Binder<String?> {
        return Binder(self.base) { (button, animationName) -> Void in
            button.animationName = animationName
        }
    }
}
