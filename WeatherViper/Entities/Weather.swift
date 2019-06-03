//
//  Weather.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let description: String
    let icon: String
}

struct MainInfo: Decodable {
    let temp: Double
}

struct Clouds: Decodable {
    let cloudiness: Double
    
    private enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}

struct Wind: Decodable {
    let speed: Double
    let degree: Double
    
    private enum CodingKeys: String, CodingKey {
        case speed, degree = "deg"
    }
}

struct WeatherResponseBody: Decodable {
    let weather: [Weather]
    let mainInfo: MainInfo
    let clouds: Clouds
    let wind: Wind
    
    private enum CodingKeys: String, CodingKey {
        case weather, mainInfo = "main", clouds, wind
    }
}
