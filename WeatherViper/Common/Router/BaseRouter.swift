//
//  BaseRouter.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class BaseRouter {
    weak var viewController: UIViewController?
    
    init() {
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
