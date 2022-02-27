//
//  TodayViewPresenter.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit
import CoreLocation

class TodayViewPresenter: TodayViewPresenterProtocol {
    
    // MARK: - Public Data
    weak var view: TodayViewControllerProtocol?

    // MARK: - Private Data
    private var placemark: CLPlacemark?
    private let dataManager: WeatherServiceProtocol
    private var forecastMap: ForecastMap?

    // MARK: - Initialization
    init(view: TodayViewControllerProtocol, dataManager: WeatherServiceProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        LocationManager.shared.currentPlacemark() { [weak self] placemark in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.placemark = placemark
                self.dataManager.getCurrentWeather { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let weather):
                            self.forecastMap = weather
                            self.view?.updateUI()
                        case .failure(let error):
                            self.view?.showErrorAlert(error: error, description: CodeMarker(self, #function, #line), errorMessage: "Failured while getting weather")
                        }
                    }
                }
            }
        }
    }
    
    func shareButtonTapped() {
        
    }
    
    func getTodayWeatherImage() -> UIImage? {
        return dataManager.getImage(stringUrl: forecastMap?.current?.weather?.first?.iconURL ?? "")
    }
    
    func getLocationNameText() -> String? {
        guard let city = placemark?.locality else {
              return " "
        }
        return city
    }
    
    func getCurrentWeatherText() -> String? {
        let temperature = forecastMap?.current?.temperature?.toTempratureInCelscious() ?? ""
        let weatherDescription = forecastMap?.current?.weather?.first?.main ?? ""
        return temperature + " | " + weatherDescription
    }
    
    func getHumidityText() -> String? {
        return forecastMap?.current?.humidity?.toHumidity()
    }
    
    func getPrecipitationText() -> String? {
        return forecastMap?.minutely?.first?.precipitation?.toPrecipitation()
    }
    
    func getPressureText() -> String? {
        return forecastMap?.current?.pressure?.toPressure()
    }
    
    func getWindSpeedText() -> String? {
        return forecastMap?.current?.windSpeed?.toWindSpeed()
    }
    
    func getWindDirectionText() -> String? {
        return forecastMap?.current?.windDegree?.windDirection()
    }
}
