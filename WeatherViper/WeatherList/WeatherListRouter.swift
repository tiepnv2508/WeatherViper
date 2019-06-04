//
//  WeatherListRouter.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

class WeatherListRouter: BaseRouter, WeatherListRouterProtocol {
    func transistTo(_ builder: BaseBuilder) {
        let newVC = builder.provide()
        viewController?.navigationController?.pushViewController(newVC, animated: true)
    }
}
