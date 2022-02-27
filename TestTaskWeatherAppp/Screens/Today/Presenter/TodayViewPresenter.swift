//
//  TodayViewPresenter.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit
import CoreLocation

class TodayViewPresenter: TodayViewPresenterProtocol {
    
    // MARK: - Public Data
    weak var view: TodayViewControllerProtocol?

    // MARK: - Private Data
    private var placemark: CLPlacemark?

    // MARK: - Initialization
    init(view: TodayViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        LocationManager.shared.currentPlacemark() { [weak self] placemark in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.placemark = placemark
                self.view?.updateUI()
            }
        }
    }
    
    func shareButtonTapped() {
        
    }
    
    func getTodayWeatherImage() -> UIImage? {
        return nil
    }
    
    func getLocationNameText() -> String {
        guard let city = placemark?.locality else {
              return " "
        }
        return city
    }
}
