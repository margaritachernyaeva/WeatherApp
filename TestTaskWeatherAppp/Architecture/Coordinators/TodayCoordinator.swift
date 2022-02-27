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
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    func start() {
        showTodayViewController()
    }
    
    // MARK: - Private Methods
    private func showTodayViewController() {
        let viewController = TodayViewController()
        viewController.presenter = TodayViewPresenter(view: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}
