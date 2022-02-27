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
    func getLocationNameText() -> String
}
