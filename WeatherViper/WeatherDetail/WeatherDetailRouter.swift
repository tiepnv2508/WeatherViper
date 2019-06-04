//
//  WeatherDetailRouter.swift
//  WeatherViper
//
//  Created by Kaka on 6/4/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherDetailRouter: BaseRouter, WeatherDetailRouterProtocol {
    func transistBack() {
        viewController?.dismiss(animated: true)
    }
}
