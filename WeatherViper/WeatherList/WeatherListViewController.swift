//
//  WeatherListViewController.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import UIKit

class WeatherListViewController: UITableViewController {
    var presenter: WeatherListPresenterProtocol?
    weak var activityIndicator: UIActivityIndicatorView!
    
    var weatherModels: [WeatherModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicator)
        self.activityIndicator = activityIndicator
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

extension WeatherListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListCell", for: indexPath) as? WeatherListCell
        if cell == nil {
            cell = WeatherListCell(style: .default, reuseIdentifier: "WeatherListCell")
        }
        let weather = weatherModels[indexPath.row]
        cell?.weatherModel = weather
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherModel = weatherModels[indexPath.row]
        presenter?.showWeatherDetail(weatherModel)
    }
}

extension WeatherListViewController: WeatherListViewProtocol {
    func displayLoading() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func showWeatherList(_ weatherModels: [WeatherModel]) {
        stopLoading()
        self.weatherModels = weatherModels
    }
    
    func showErrorMessage(_ message: String) {
        stopLoading()
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
