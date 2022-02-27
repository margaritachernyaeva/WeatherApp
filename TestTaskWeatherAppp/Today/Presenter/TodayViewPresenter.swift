//
//  TodayViewPresenter.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

class TodayViewPresenter: TodayViewPresenterProtocol {
    // MARK: - Public Data
    weak var view: TodayViewControllerProtocol?
    
    // MARK: - Initialization
    init(view: TodayViewControllerProtocol) {
        self.view = view
    }
    
    // MARK: - Public Methods
    func shareButtonTapped() {
        
    }
    
    func getTodayWeatherImage() -> UIImage? {
        return nil
    }
    
}
