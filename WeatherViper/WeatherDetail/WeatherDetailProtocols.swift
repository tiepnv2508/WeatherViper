//
//  WeatherDetailProtocols.swift
//  WeatherViper
//
//  Created by Kaka on 6/4/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

protocol WeatherDetailViewProtocol: class {
    var presenter: WeatherDetailPresenterProtocol? { get set }
    
    func showWeather(_ weatherModel: WeatherModel)
}

protocol WeatherDetailPresenterProtocol: class {
    var view: WeatherDetailViewProtocol? { get set }
    var interactor: WeatherDetailInteractorInputProtocol? { get set }
    var router: WeatherDetailRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol WeatherDetailInteractorInputProtocol: class {
    var weatherModel: WeatherModel? { get set }
}

protocol WeatherDetailRouterProtocol: class {
    func transistBack()
}
