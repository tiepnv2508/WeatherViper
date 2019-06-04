//
//  WeatherListProtocols.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

protocol WeatherListViewProtocol: class {
    var presenter: WeatherListPresenterProtocol? { get set }
    
    func showWeatherList(_ weatherModels: [WeatherModel])
    func showErrorMessage(_ message: String)
}

protocol WeatherListPresenterProtocol: class {
    var view: WeatherListViewProtocol? { get set }
    var interactor: WeatherListInteractorInputProtocol? { get set }
    var router: WeatherListRouterProtocol? { get set }
    
    func viewWillAppear()
    func showWeatherDetail(_ weatherModel: WeatherModel)
}

protocol WeatherListInteractorInputProtocol: class {
    var presenter: WeatherListInteractorOutputProtocol? { get set }
    
    func retrieveCurrentWeather()
    func retrieveWeathers()
}

protocol WeatherListInteractorOutputProtocol: class {
    func didRetrieveCurrentWeather(_ weatherModels: [WeatherModel])
    func didRetrieveWeathers(_ weatherModels: [WeatherModel])
    func onError(message: String)
}

protocol WeatherListRouterProtocol: class {
    func transistTo(_ builder: BaseBuilder)
}
