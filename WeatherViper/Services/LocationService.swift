//
//  LocationService.swift
//  WeatherViper
//
//  Created by Kaka on 6/3/19.
//  Copyright © 2019 Tiep Nguyen. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    typealias Coordinate = (latitude: String, longitude: String)
    private var locationManagerCallback: ((Coordinate) -> Void)?
    
    public static let shared = LocationService()
    private var locManager = CLLocationManager()
    private let isAuthorized: Bool = {
       return CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways
    }()
    
    override init() {
        super.init()
        locManager.delegate = self
        if( CLLocationManager.authorizationStatus() == .notDetermined){
            locManager.requestWhenInUseAuthorization()
        }
    }
    
    private func getCurrentCoordinate() -> Coordinate {
        let coord = locManager.location?.coordinate
        let latitude = String(coord!.latitude)
        let longitude = String(coord!.longitude)
        let result = (latitude, longitude)
        return result
    }
    
    func getCurrentCoordinate(completion: @escaping (Coordinate) -> Void) {
        locationManagerCallback = completion
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            completion(getCurrentCoordinate())
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if isAuthorized { return }
            locationManagerCallback?(getCurrentCoordinate())
        }
    }
}
