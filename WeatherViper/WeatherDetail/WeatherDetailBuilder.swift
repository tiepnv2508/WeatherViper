//
//  WeatherDetailBuilder.swift
//  WeatherViper
//
//  Created by Kaka on 6/4/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherDetailBuilder: BaseBuilder {
    var weatherModel: WeatherModel?
    
    init(weatherModel: WeatherModel) {
        self.weatherModel = weatherModel
    }
    
    func provide() -> UIViewController {
        //Create Layers
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let weatherDetailVC = storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController else {
            fatalError("Invalid view controller type")
        }
        
        let presenter: WeatherDetailPresenterProtocol = WeatherDetailPresenter()
        let interactor: WeatherDetailInteractorInputProtocol = WeatherDetailInteractor()
        let router: WeatherDetailRouterProtocol = WeatherDetailRouter()
        
        //Connect Layers
        weatherDetailVC.presenter = presenter
        presenter.view = weatherDetailVC
        presenter.interactor = interactor
        presenter.router = router
        interactor.weatherModel = weatherModel
        
        return weatherDetailVC
    }
    
    
}
