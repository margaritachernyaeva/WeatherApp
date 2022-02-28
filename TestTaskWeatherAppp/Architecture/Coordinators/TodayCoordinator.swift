//
//  TodayCoordinator.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

class TodayCoordinator: NavigationCoordinator {
    // MARK: - Public Data
    var navigationController: UINavigationController
    let weatherService: WeatherServiceProtocol
    
    // MARK: - Initialization
    init(navigationController: UINavigationController, weatherService: WeatherServiceProtocol) {
        self.navigationController = navigationController
        self.weatherService = weatherService
    }
    
    // MARK: - Public Methods
    func start() {
        showTodayViewController()
    }
    
    // MARK: - Private Methods
    private func showTodayViewController() {
        let viewController = TodayViewController()
        viewController.presenter = TodayViewPresenter(view: viewController, dataManager: weatherService)
        navigationController.pushViewController(viewController, animated: true)
    }
}
