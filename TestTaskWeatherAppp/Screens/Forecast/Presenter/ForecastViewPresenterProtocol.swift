//
//  ForecastViewPresenterProtocol.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import Foundation

protocol ForecastViewPresenterProtocol: AnyObject {
    func getNavigationBarTitle() -> String?
    func cellCount() -> Int
}
