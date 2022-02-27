//
//  TodayViewPresenterProtocol.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

protocol TodayViewPresenterProtocol: AnyObject {
    // Actions
    func shareButtonTapped()
    // Getters
    func getTodayWeatherImage() -> UIImage?
}
