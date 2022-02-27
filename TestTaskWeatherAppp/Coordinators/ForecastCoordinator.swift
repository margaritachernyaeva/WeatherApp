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
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    func start() {
        showForecastViewController()
    }
    
    // MARK: - Private Methods
    private func showForecastViewController() {
        let viewController = ForecastViewController()
        viewController.presenter = ForecastViewPresenter(view: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
