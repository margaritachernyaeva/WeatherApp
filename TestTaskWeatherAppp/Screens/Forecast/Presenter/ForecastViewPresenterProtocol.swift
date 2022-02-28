//
//  ForecastViewPresenterProtocol.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import Foundation

protocol ForecastViewPresenterProtocol: AnyObject {
    //Actions
    func viewDidLoad()
    //Getters
    func getNavigationBarTitle() -> String?
    func cellCount(for section: Int) -> Int
    func numberOfSections() -> Int
    func getCellModel(for indexPath: IndexPath) -> HourForecastCellModel
    func getTitle(for section: Int) -> String?
}
