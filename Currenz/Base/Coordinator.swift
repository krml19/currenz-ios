//
//  Coordinator.swift
//  Currenz
//
//  Created by Marcin Karmelita on 16/07/2018.
//  Copyright © 2018 Marcin Karmelita. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
    func stop()
    
    var presentation: Presentation { get }
    init(presentation: Presentation)
}

extension Coordinator {
    func stop() {
        presentation.pop()
    }
}

