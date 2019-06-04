//
//  WeatherDetailPresenter.swift
//  WeatherViper
//
//  Created by Kaka on 6/4/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherDetailPresenter: WeatherDetailPresenterProtocol {
    weak var view: WeatherDetailViewProtocol?
    var interactor: WeatherDetailInteractorInputProtocol?
    var router: WeatherDetailRouterProtocol?
    
    func viewDidLoad() {
        if let weatherModel = interactor?.weatherModel {
            view?.showWeather(weatherModel)
        }
    }
}
