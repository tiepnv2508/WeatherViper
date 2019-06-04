//
//  WeatherListInteractor.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherListInteractor: WeatherListInteractorInputProtocol {
    weak var presenter: WeatherListInteractorOutputProtocol?
    let weatherService = WeatherService.shared
    let locationService = LocationService.shared
    var weatherModels: [WeatherModel] = []
    
    func retrieveWeathers() {
        weatherService.fetchWeathers(cityIds: [2643743, 1850147], unit: .imperial) { [weak self](result) in
            guard let weakSelf = self else { return }
            switch result {
            case .success(let weatherList):
                weatherList.list.forEach { weakSelf.weatherModels.append($0) }
                weakSelf.presenter?.didRetrieveWeathers(weakSelf.weatherModels)
            case .failure(let error):
                weakSelf.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
    
    func retrieveCurrentWeather() {
        locationService.getCurrentCoordinate { [weak self](result) in
            self?.weatherService.fetchWeather(latitude: result.latitude, longitude: result.longitude, unit: .imperial) { [weak self](result) in
                guard let weakSelf = self else { return }
                switch result {
                case .success(let currentWeather):
                    weakSelf.weatherModels.insert(currentWeather, at: 0)
                    weakSelf.presenter?.didRetrieveCurrentWeather(weakSelf.weatherModels)
                case .failure(let error):
                    weakSelf.presenter?.onError(message: error.localizedDescription)
                }
            }
        }
    }
}
