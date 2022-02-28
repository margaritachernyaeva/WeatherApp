//
//  LocationManager.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Public Data
    static let shared = LocationManager()
    var latitude: Double?
    var longitude: Double?
    
    // MARK: - Private Data
    private let cllManager = CLLocationManager()
    private var completion: ((Result<CLPlacemark, Error>) -> Void)?
    
    // MARK: - Initialization
    private override init() {
        super.init()
        cllManager.delegate = self
    }
    
    // MARK: - Public Methods
    func currentPlacemark(completion: @escaping ((Result<CLPlacemark, Error>) -> Void)) {
        currentPlacemarkInBackground { result in
            DispatchQueue.main.async { completion(result) }
        }
    }
    
    // MARK: - Private Methods
    private func currentPlacemarkInBackground(completion: @escaping (Result<CLPlacemark, Error>) -> Void) {
        self.completion = completion
        cllManager.startUpdatingLocation()
        cllManager.requestWhenInUseAuthorization()
    }
    
    private func convertLocationIntoPlacemark(_ location: CLLocation, completion: @escaping (Result<CLPlacemark, Error>) -> Void) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        self.latitude = latitude
        self.longitude = longitude
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation (location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let error = error {
                    self.completion?(.failure(error))
                    return
                }
                if let placemark = placemarks?.first {
                    self.completion?(.success(placemark))
                } else {
                    self.completion?(.failure(CommonError.nilValue("placemark")))
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        cllManager.stopUpdatingLocation()
        guard let location = locations.first else {
            completion?(.failure(CommonError.nilValue("location")))
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
        completion?(.failure(error))
    }

    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            cllManager.startUpdatingLocation()
        case .notDetermined, .restricted, .denied:
            completion?(.failure(CommonError.locationDetermineRestricted))
        @unknown default:
            completion?(.failure(CommonError.unknownError))
        }
    }
}
    
