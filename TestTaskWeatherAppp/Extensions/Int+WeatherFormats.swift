//
//  Int+WeatherFormats.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation

extension Int {
    func toHumidity() -> String {
        return String(self) + "%"
    }
    
    func toPressure() -> String {
        return String(self) + " hPa"
    }
    
    func windDirection() -> String? {
        let degreeUnit = Int(Double(self) / 22.5 + 0.5)
        let directions = ["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
        return directions[(degreeUnit % 16)]
    }
}
