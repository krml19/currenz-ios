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
        UINavigationBar.appearance().barTintColor = UIColor.flatForestGreenColorDark()
        UINavigationBar.appearance().tintColor = UIColor.flatWhite()
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatWhite()]
        
        UIBarButtonItem.appearance().tintColor = UIColor.flatWhite()
        
        UITableView.appearance().backgroundColor = .clear
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.flatWhite()]
        UISearchBar.appearance().tintColor = UIColor.flatWhite()
    }
}
