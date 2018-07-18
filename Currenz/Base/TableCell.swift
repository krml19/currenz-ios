//
//  TableCell.swift
//  Currenz
//
//  Created by Marcin Karmelita on 17/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit
import RxSwift
import Reusable

open class TableCell<ViewModelType>: UITableViewCell {
    var disposeBag = DisposeBag()
    
    override open func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    open func configure(viewModel: ViewModelType) {
        
    }
}

// MARK: - NibReusable
extension TableCell: NibReusable {}
