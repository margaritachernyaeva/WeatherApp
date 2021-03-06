//
//  TodayViewPresenterProtocol.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

protocol TodayViewPresenterProtocol: AnyObject {
    // Actions
    func viewDidLoad()
    func shareButtonTapped()
    // Getters
    func getTodayWeatherImage() -> UIImage?
    func getLocationNameText() -> String?
    func getCurrentWeatherText() -> String?
    func getHumidityText() -> String?
    func getPrecipitationText() -> String?
    func getPressureText() -> String?
    func getWindSpeedText() -> String?
    func getWindDirectionText() -> String?
}
