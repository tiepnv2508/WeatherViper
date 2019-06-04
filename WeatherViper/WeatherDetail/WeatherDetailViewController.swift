//
//  WeatherDetailViewController.swift
//  WeatherViper
//
//  Created by Kaka on 6/4/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegreeLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    
    var presenter: WeatherDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension WeatherDetailViewController: WeatherDetailViewProtocol {
    func showWeather(_ weatherModel: WeatherModel) {
        var weather = weatherModel
        self.title = weather.cityName
        windSpeedLabel.text = weather.wind.speedText
        windDegreeLabel.text = weather.wind.degreeText
        cloudinessLabel.text = weather.clouds.cloudinessText
    }
}
