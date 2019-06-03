//
//  WeatherService.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

class WeatherService {
    public static let shared = WeatherService()
    private init() {}
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5")!
    private let appId = "121f4d588322b257301cd4815cc56499"
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
}
