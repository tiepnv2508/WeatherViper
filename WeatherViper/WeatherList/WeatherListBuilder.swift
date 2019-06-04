//
//  WeatherListBuilder.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherListBuilder: BaseBuilder {
    func provide() -> UIViewController {
        //Create Layers
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navVC = storyboard.instantiateViewController(withIdentifier: "WeatherListNavigation") as! UINavigationController
        guard let weatherListVC = navVC.topViewController as? WeatherListViewController else {
            fatalError("Invalid View Controller")
        }
        
        let presenter: WeatherListPresenterProtocol & WeatherListInteractorOutputProtocol = WeatherListPresenter()
        let interactor: WeatherListInteractorInputProtocol = WeatherListInteractor()
        let router = WeatherListRouter(viewController: weatherListVC)
        
        //Connect Layers
        weatherListVC.presenter = presenter
        presenter.view = weatherListVC
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navVC
    }
}
