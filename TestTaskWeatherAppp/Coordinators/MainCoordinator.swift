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

class MainCoordinator: NSObject, TabCoordinator, UITabBarControllerDelegate, CLLocationManagerDelegate {
    
    // MARK: - Public Data
    var tabBarController: UITabBarController = UITabBarController()
    
    // MARK: - Private Data
    private let locationManager = CLLocationManager()

    // MARK: - Initialization
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    // MARK: - Public Methods
    func start() {
        locationManager.delegate = self
        locationManager.requestLocation()
        let pages: [TabBarPage] = [.today, .forecast]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        prepareTabBarController(withTabControllers: controllers)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: - Handle error
    }
    
    // MARK: - Private Methods
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: nil, image: page.pageIcon(), tag: page.index())
        page.startCoordinator(navigationController: navigationController)
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
