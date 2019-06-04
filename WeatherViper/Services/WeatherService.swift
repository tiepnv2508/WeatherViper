//
//  WeatherService.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

enum Endpoint: String{
    case weather
    case group
}

enum Params: String {
    case latitude = "lat"
    case longitude = "lon"
    case query = "q"
    case id
    case units
    case appid
}

enum Units: String {
    case metric
    case imperial
}

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
    
    private func fetchResources<T: Decodable>(url: URL, params: [URLQueryItem], completion: @escaping (Result<T, APIServiceError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        let queryItems = [URLQueryItem(name: Params.appid.rawValue, value: appId)] + params
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                //If success, we retrieve the data then check the response HTTP status code
                //to make sure it’s in the range between 200 and 299
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(values))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure(_):
                completion(.failure(.apiError))
            }
        }.resume()
    }

    //****************************************************
    //* Get weather data by latitude and longitude
    //* Params: latitude, longitude, unit
    //* Return values: Weather
    //****************************************************
    public func fetchWeather(latitude: String, longitude: String, unit: Units, result: @escaping (Result<WeatherModel, APIServiceError>) -> Void) {
        let weatherURL = baseURL.appendingPathComponent(Endpoint.weather.rawValue)
        let params = [URLQueryItem(name: Params.latitude.rawValue, value: latitude),
                      URLQueryItem(name: Params.longitude.rawValue, value: longitude),
                      URLQueryItem(name: Params.units.rawValue, value: unit.rawValue)]
        fetchResources(url: weatherURL, params: params, completion: result)
    }
    
    //****************************************************
    //* Get weather data by city name and county code
    //* Params: city, country code, unit
    //* Return values: Weather
    //****************************************************
    public func fetchWeather(city: String, countryCode: String, unit: Units, result: @escaping (Result<WeatherModel, APIServiceError>) -> Void) {
        let weatherURL = baseURL.appendingPathComponent(Endpoint.weather.rawValue)
        let query = "\(city),\(countryCode)"
        let params = [URLQueryItem(name: Params.query.rawValue, value: query),
                      URLQueryItem(name: Params.units.rawValue, value: unit.rawValue)]
        fetchResources(url: weatherURL, params: params, completion: result)
    }
    
    //****************************************************
    //* Get weather data list by a group of city Ids
    //* Params: cityIds, unit
    //* Return values: Weather
    //****************************************************
    public func fetchWeathers(cityIds: [Int], unit: Units, result: @escaping (Result<ListWeatherResponseBody, APIServiceError>) -> Void) {
        let weatherURL = baseURL.appendingPathComponent(Endpoint.group.rawValue)
        let query = cityIds.reduce("") {
            String($0).isEmpty ? String($1) :  String($0) + "," + String($1)
        }
        let params = [URLQueryItem(name: Params.id.rawValue, value: query),
                      URLQueryItem(name: Params.units.rawValue, value: unit.rawValue)]
        fetchResources(url: weatherURL, params: params, completion: result)
    }
}
