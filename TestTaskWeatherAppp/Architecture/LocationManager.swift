//
//  LocationManager.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    var latitude: Double?
    var longitude: Double?
    private let cllManager = CLLocationManager()
    private var completion: ((CLPlacemark?) -> Void)?
    
    private override init() {
        super.init()
        cllManager.delegate = self
    }
    
    func currentPlacemark(completion: @escaping (CLPlacemark?) -> Void) {
        self.completion = completion
        cllManager.requestWhenInUseAuthorization()
        cllManager.startUpdatingLocation()
    }
    
    private func convertLocationIntoPlacemark(_ location: CLLocation, completion: @escaping (CLPlacemark) -> Void) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        WeatherManager.latitude = latitude
        WeatherManager.longitude = longitude
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation (location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let _ = error {
                self.completion?(nil)
                return
            }
            DispatchQueue.main.async {
                let placemark = placemarks?.first
                self.completion?(placemark)
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        cllManager.stopUpdatingLocation()
        guard let location = locations.first else {
            completion?(nil)
            return
        }
        convertLocationIntoPlacemark(location) { [weak self] placemark in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.completion?(placemark)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: Error Handle It!
    }

    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // TODO: Complete method
        if status == .authorizedWhenInUse {
            cllManager.startUpdatingLocation()
            
        }
    }
}
    
