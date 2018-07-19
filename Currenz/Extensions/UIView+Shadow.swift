//
//  UIView+Shadow.swift
//  Currenz
//
//  Created by Marcin Karmelita on 19/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(width: CGFloat = 1, color: UIColor = UIColor.black.withAlphaComponent(0.5), radius: CGFloat = 5, offset: CGSize = CGSize(width: 0, height: 3), opacity: Float = 0.5, shouldRasterize: Bool = true) {
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.cornerRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shouldRasterize = shouldRasterize
    }
}
