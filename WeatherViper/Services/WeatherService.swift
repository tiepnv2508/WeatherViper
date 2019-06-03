//
//  WeatherService.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation

enum Endpoint: String, CustomStringConvertible, CaseIterable {
    case weather
    
    var description: String {
        return "\(self.rawValue)"
    }
}

enum Params: String {
    case latitude = "lat"
    case longitude = "lon"
    case query = "q"
    
    var description: String {
        return "\(self.rawValue)"
    }
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
        
        let queryItems = [URLQueryItem(name: "appid", value: appId)] + params
        
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
    
    public func fetchWeather(from endpoint: Endpoint, latitude: String, longitude: String, result: @escaping (Result<WeatherResponseBody, APIServiceError>) -> Void) {
        let weatherURL = baseURL.appendingPathComponent(endpoint.rawValue)
        let params = [URLQueryItem(name: Params.latitude.rawValue, value: latitude),
                      URLQueryItem(name: Params.longitude.rawValue, value: longitude)]
        fetchResources(url: weatherURL, params: params, completion: result)
    }
    
    public func fetchWeather(from endpoint: Endpoint, city: String, countryCode: String, result: @escaping (Result<WeatherResponseBody, APIServiceError>) -> Void) {
        let weatherURL = baseURL.appendingPathComponent(endpoint.rawValue)
        let query = "\(city),\(countryCode)"
        let params = [URLQueryItem(name: Params.query.rawValue, value: query)]
        fetchResources(url: weatherURL, params: params, completion: result)
    }
}
