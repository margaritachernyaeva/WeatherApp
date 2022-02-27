//
//  ForecastViewPresenter.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import Foundation

class ForecastViewPresenter: ForecastViewPresenterProtocol {
    
    weak var view: ForecastViewControllerProtocol?
    
    init(view: ForecastViewControllerProtocol) {
        self.view = view
    }
    
    func getNavigationBarTitle() -> String? {
        // TODO: fix it
        return "Moscow"
    }
    
    func cellCount() -> Int {
        return 10
    }
}
