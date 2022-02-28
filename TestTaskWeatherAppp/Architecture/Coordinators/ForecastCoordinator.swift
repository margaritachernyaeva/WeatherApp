//
//  ForecastCoordinator.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

class ForecastCoordinator: NavigationCoordinator {
    
    // MARK: - Public Data
    var navigationController: UINavigationController
    
    // MARK: - Private Data
    let weatherService: WeatherServiceProtocol
    
    // MARK: - Initialization
    init(navigationController: UINavigationController, weatherService: WeatherServiceProtocol) {
        self.navigationController = navigationController
        self.weatherService = weatherService
    }
    
    // MARK: - Public Methods
    func start() {
        showForecastViewController()
    }
    
    // MARK: - Private Methods
    private func showForecastViewController() {
        let viewController = ForecastViewController()
        viewController.presenter = ForecastViewPresenter(view: viewController, dataManager: weatherService)
        navigationController.pushViewController(viewController, animated: true)
    }
}
