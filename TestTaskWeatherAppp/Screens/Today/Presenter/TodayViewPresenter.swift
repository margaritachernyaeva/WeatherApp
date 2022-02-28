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
    private let dataManager: WeatherServiceProtocol
    private var forecastMap: ForecastMap?

    // MARK: - Initialization
    init(view: TodayViewControllerProtocol, dataManager: WeatherServiceProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        guard dataManager.forecastMap != nil else {
            loadForecast()
            return
        }
        self.forecastMap = dataManager.forecastMap
    }
    
    func loadForecast() {
        dataManager.getWeatherForecast { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let forecastMap):
                self.forecastMap = forecastMap
                self.view?.updateUI()
            case .failure(let error):
                self.view?.showErrorAlertWithLog(error: error,
                                     description: CodeMarker(self, #function, #line),
                                     errorMessage: "Couldnt load forecast")
            }
        }
    }
    
    func shareButtonTapped() {
        view?.showShareController(with: "Today Forecast: \(forecastMap?.current?.temperature?.toTempratureInCelscious() ?? "")")
    }
    
    func getTodayWeatherImage() -> UIImage? {
        return dataManager.getImage(stringUrl: forecastMap?.current?.weather?.first?.iconURL ?? "")
    }
    
    func getLocationNameText() -> String? {
        return dataManager.getPlacemark()?.locality ?? ""
    }
    
    func getCurrentWeatherText() -> String? {
        let temperature = forecastMap?.current?.temperature?.toTempratureInCelscious() ?? ""
        let weatherDescription = forecastMap?.current?.weather?.first?.description ?? ""
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
