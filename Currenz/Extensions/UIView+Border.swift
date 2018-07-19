//
//  UIView+Border.swift
//  Currenz
//
//  Created by Marcin Karmelita on 19/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

extension UIView {
    func borders(color: UIColor = UIColor.flatWhiteColorDark(), width: CGFloat = 1, radius: CGFloat? = nil) {
        layer.masksToBounds = true
        let radius = radius ?? frame.height / 2
        layer.cornerRadius = radius
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
