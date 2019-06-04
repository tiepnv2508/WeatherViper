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
    var weatherModels: [WeatherService]?
    
    func retrieveWeathers() {
        weatherService.fetchWeathers(cityIds: [2643743, 1850147], unit: .imperial) { [weak self](result) in
            switch result {
            case .success(let weatherList):
                self?.presenter?.didRetrieveWeathers(weatherList.list)
            case .failure(let error):
                self?.presenter?.onError(message: error.localizedDescription)
            }
        }
    }
}
