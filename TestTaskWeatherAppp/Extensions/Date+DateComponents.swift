//
//  Date+DateComponents.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 28.02.22.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
}
