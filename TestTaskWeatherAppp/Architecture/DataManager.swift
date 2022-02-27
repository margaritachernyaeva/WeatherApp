//
//  DataManager.swift
//  
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import UIKit

protocol WeatherServiceProtocol {
    func getCurrentWeather(completion: @escaping (Result<ForecastMap, Error>) ->())
    func getImage(stringUrl: String) -> UIImage?
}
    
class WeatherManager: WeatherServiceProtocol {
    
    // MARK: - Public Data
    static var longitude = LocationManager.shared.longitude ?? 0
    static var latitude = LocationManager.shared.latitude ?? 0
    
    // MARK: - Private Data
    private let apiKey = "11a0a683004a18c77c59b1f3ea862ff8"
    private var apiURL: String {
        let url = "https://api.openweathermap.org/data/2.5/onecall?lat=\(WeatherManager.latitude)&lon=\(WeatherManager.longitude)&units=metric&appid=\(apiKey)"
        return url
    }
    private let view: BaseViewControllerProtocol
    
    // MARK: - Initialization
    init(view: BaseViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - P ublic Methods
    func getCurrentWeather(completion: @escaping (Result<ForecastMap, Error>) ->()) {
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
                completion(.success(json))
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
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
}
