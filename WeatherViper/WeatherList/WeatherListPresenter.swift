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
    
    func viewWillAppear() {
        interactor?.retrieveWeathers()
    }
    
    func showWeatherDetail(_ weatherModel: WeatherModel) {
        //let builder = WeatherDetailBuilder()
        //router?.transistTo(builder)
    }
}

extension WeatherListPresenter: WeatherListInteractorOutputProtocol {
    func didRetrieveWeathers(_ weatherModels: [WeatherModel]) {
        view?.showWeatherList(weatherModels)
    }
    
    func onError(message: String) {
        view?.showErrorMessage(message)
    }
}
