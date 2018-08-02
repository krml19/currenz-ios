//
//  UITableView+Configure.swift
//  Currenz
//
//  Created by Marcin Karmelita on 18/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import Reusable

extension UITableView {
    func configure<T: UITableViewCell>(registerCells: [T.Type], tableFooterView: UIView = UIView(), tableHeaderView: UIView? = nil) where T: Reusable & NibLoadable {
        self.tableFooterView = tableFooterView
        self.tableHeaderView = tableHeaderView
        
        registerCells.forEach({ register(cellType: $0) })
    }
}
