//
//  DataManager.swift
//  
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import UIKit
import CoreLocation

protocol WeatherServiceProtocol {
    var forecastMap: ForecastMap? { get }
    func getPlacemark() -> CLPlacemark?
    func getWeatherForecast(completion: @escaping (Result<ForecastMap, Error>) ->())
    func getImage(stringUrl: String) -> UIImage?
}
    
class WeatherManager: WeatherServiceProtocol {
    
    var forecastMap: ForecastMap?
    private var placemark: CLPlacemark?
    
    // MARK: - Private Data
    private let apiKey = APIKey
    private var apiURL: String {
        let langStr = Locale.current.languageCode
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&units=metric&lang=\(langStr ?? "")&appid=\(apiKey)"
        return url
    }
    private var latitude: String {
        return String(LocationManager.shared.latitude ?? 0)
    }
    private var longitude: String {
        return String(LocationManager.shared.longitude ?? 0)
    }
    private let view: UIViewController
    
    // MARK: - Initialization
    init(view: UIViewController) {
        self.view = view
    }
    
    // MARK: - Public Methods
    func getPlacemark() -> CLPlacemark? {
        return placemark
    }

    func getWeatherForecast(completion: @escaping (Result<ForecastMap, Error>) -> ()) {
        LocationManager.shared.currentPlacemark() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let placemark):
                    self.placemark = placemark
                    self.getWeatherForecastInBackground { result in
                        DispatchQueue.main.async { completion(result) }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getImage(stringUrl: String) -> UIImage? {
        guard let url = URL(string: stringUrl) else {
            NSLog(CodeMarker(self, #function, #line).description)
            return nil
        }
        let data = try? Data(contentsOf: url)
        guard let imageData = data else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        return image
    }

    // MARK: - Private Methods
    func getWeatherForecastInBackground(completion: @escaping (Result<ForecastMap, Error>) ->()) {
        guard let url = URL(string: apiURL) else { return }
        URLSession.shared.dataTask(with: url) {  data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            var result: ForecastMap?
            do {
                result = try JSONDecoder().decode(ForecastMap.self, from: data)
                guard let json = result else { return }
                self.forecastMap = json
                completion(.success(json))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}
