//
//  Appearance.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import ChameleonFramework

struct Appearance {
    static func configure() {
        configureNavBar()
    }
    
    private static func configureNavBar() {
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().barTintColor = UIColor.flatForestGreenColorDark()
//        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.flatWhite()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatWhite()]
        
        UIBarButtonItem.appearance().tintColor = UIColor.flatWhite()

        UISearchBar.appearance().backgroundColor = UIColor.flatWhite()
        
        UITableView.appearance().backgroundColor = .clear
    }
}
