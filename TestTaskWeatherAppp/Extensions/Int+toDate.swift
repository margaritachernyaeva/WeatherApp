//
//  Int+toDate.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 28.02.22.
//

import Foundation

extension Int {
    
    func toDate() -> Date? {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
