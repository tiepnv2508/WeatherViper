//
//  WeatherListCell.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherListCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var weatherModel: WeatherModel? {
        didSet {
            setupUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupUI() {
        guard var model = weatherModel else { return }
        cityLabel.text = model.cityName
        tempLabel.text = model.mainInfo.tempText
        let iconUrl = model.weather[0].iconUrl
        weatherIcon.image = UIImage(named: iconUrl)
    }
}
