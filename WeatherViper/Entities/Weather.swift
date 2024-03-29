//
//  Weather.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    var weather: [Weather]
    var mainInfo: MainInfo
    var clouds: Clouds
    var wind: Wind
    let cityName: String
    
    private enum CodingKeys: String, CodingKey {
        case weather, mainInfo = "main", clouds, wind, cityName = "name"
    }
}

struct Weather: Decodable {
    let description: String
    let icon: String
    
    lazy var iconUrl:String = "https://openweathermap.org/img/w/\(icon).png"
}

struct MainInfo: Decodable {
    let temp: Double
    
    lazy var tempText:String = "\(Int(round(temp)))°"
}

struct Clouds: Decodable {
    let cloudiness: Double
    
    lazy var cloudinessText:String = "Cloudiness: \(Int(round(cloudiness)))%"
    
    private enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}

struct Wind: Decodable {
    let speed: Double
    let degree: Double
    
    lazy var speedText:String = "Wind speed: \(Int(round(speed)))mps"
    lazy var degreeText:String = "Wind degree: \(Int(round(degree)))°"
    
    private enum CodingKeys: String, CodingKey {
        case speed, degree = "deg"
    }
}

struct ListWeatherResponseBody: Decodable {
    let list: [WeatherModel]
}
