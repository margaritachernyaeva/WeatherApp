//
//  ViewController.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 25.02.22.
//

import UIKit
import CoreLocation

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

enum TabBarPage {
    case today
    case forecast

    init?(index: Int) {
        switch index {
        case 0:
            self = .today
        case 1:
            self = .forecast
        default:
            return nil
        }
    }
    
    func index() -> Int {
        switch self {
        case .today:
            return 0
        case .forecast:
            return 1
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .today:
            return UIImage(named: "ic_sun")
        case .forecast:
            return UIImage(named: "ic_sun")
        }
    }
    
    func startCoordinator(navigationController: UINavigationController) {
        var coordinator: NavigationCoordinator
        switch self {
        case .today:
            coordinator = TodayCoordinator(navigationController: navigationController)
        case .forecast:
            coordinator = ForecastCoordinator(navigationController: navigationController)
        }
        coordinator.start()
    }
}

