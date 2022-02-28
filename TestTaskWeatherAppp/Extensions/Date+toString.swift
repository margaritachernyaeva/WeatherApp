//
//  Date+DayOfWeek.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 28.02.22.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        return format("EEEE")
    }
    
    func toHours() -> String? {
        return format("HH:mm")
    }
    
    private func format(_ string: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = string
        return dateFormatter.string(from: self).capitalized
    }
}
