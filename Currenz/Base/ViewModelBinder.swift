//
//  ViewModelBinder.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import Foundation

protocol ViewModelBinder {
    associatedtype ViewModelType
    func bindViewModel(viewModel: ViewModelType)
}
