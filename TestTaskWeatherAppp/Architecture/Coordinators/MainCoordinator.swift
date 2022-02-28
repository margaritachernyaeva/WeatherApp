//
//  Coordinator.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 25.02.22.
//

import UIKit
import CoreLocation

protocol Coordinator {
    func start()
}

protocol TabCoordinator: Coordinator {
    var tabBarController: UITabBarController { get set }
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
}

class MainCoordinator: NSObject, TabCoordinator, UITabBarControllerDelegate {
    
    // MARK: - Public Data
    var tabBarController: UITabBarController = UITabBarController()
    
    // MARK: - Private data
    let weatherService: WeatherServiceProtocol

    // MARK: - Initialization
    init(tabBarController: UITabBarController, weatherService: WeatherServiceProtocol) {
        self.tabBarController = tabBarController
        self.weatherService = weatherService
    }
    
    // MARK: - Public Methods
    func start() {
        let pages: [TabBarPage] = [.today, .forecast]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    
    // MARK: - Private Methods
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: nil, image: page.pageIcon(), tag: page.index())
        page.startCoordinator(navigationController: navigationController, weatherService: weatherService)
        return navigationController
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = .blue
        tabBarController.tabBar.unselectedItemTintColor = .orange
        tabBarController.tabBar.addShadow()
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.today.index()
    }
}


