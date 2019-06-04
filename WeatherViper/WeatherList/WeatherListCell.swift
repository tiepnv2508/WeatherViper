//
//  WeatherListCell.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherListCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    weak var activityIndicator: UIActivityIndicatorView!
    
    var weatherModel: WeatherModel? {
        didSet {
            loadView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.weatherIcon.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.weatherIcon.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.weatherIcon.centerYAnchor),
        ])
    }
    
    private func loadView() {
        guard var model = weatherModel else { return }
        displayLoading()
        self.cityLabel.text = model.cityName
        self.tempLabel.text = model.mainInfo.tempText
        let iconUrl = URL(string: model.weather[0].iconUrl)
        self.weatherIcon.sd_setImage(with: iconUrl) { image, error, cacheType, imageURL in
            self.weatherIcon.image = image
            self.stopLoading()
        }
    }
    
    private func displayLoading() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    private func stopLoading() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
}
