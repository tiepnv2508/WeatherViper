//
//  WeatherListPresenter.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherListPresenter: WeatherListPresenterProtocol {
    weak var view: WeatherListViewProtocol?
    var interactor: WeatherListInteractorInputProtocol?
    var router: WeatherListRouterProtocol?
    
    func viewDidLoad() {
        view?.displayLoading()
        interactor?.retrieveWeathers()
        interactor?.retrieveCurrentWeather()
    }
    
    func reloadWeathers() {
        interactor?.reloadWeathers()
    }
    
    func showWeatherDetail(_ weatherModel: WeatherModel) {
        let builder = WeatherDetailBuilder(weatherModel: weatherModel)
        router?.transistTo(builder)
    }
}

extension WeatherListPresenter: WeatherListInteractorOutputProtocol {
    func didRetrieveCurrentWeather(_ weatherModels: [WeatherModel]) {
        view?.showWeatherList(weatherModels)
    }
    
    func didRetrieveWeathers(_ weatherModels: [WeatherModel]) {
        view?.showWeatherList(weatherModels)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
