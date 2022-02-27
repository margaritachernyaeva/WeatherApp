//
//  String+weatherFormats.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation

extension Double {
    func toTempratureInCelscious() -> String {
        return String(Int(self)) + "°C"
    }
    
    func toPrecipitation() -> String {
        return String(self) + "mm"
    }
    
    func toWindSpeed() -> String {
        return String(Int(self)) + "km/h"
    }
}
