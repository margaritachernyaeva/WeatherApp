//
//  Models.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation

struct ForecastMap: Decodable {
    var current: Current?
    var minutely: [MinutelyForecast]?
    var hourly: [HourlyForecast]?
}

struct Current: Decodable {
    var temperature: Double?
    var pressure: Int?
    var humidity: Int?
    var windSpeed: Double?
    var windDegree: Int?
    var weather: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case windSpeed = "wind_speed"
        case windDegree = "wind_deg"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
    }
}

struct Weather: Decodable {
    var description: String?
    var iconName: String?
    var iconURL: String? {
        guard let iconName = iconName else {
            return nil
        }
        return "http://openweathermap.org/img/wn/\(iconName)@2x.png"
    }
    
    enum CodingKeys: String, CodingKey {
        case iconName = "icon"
        case description = "description"
    }
}

struct MinutelyForecast: Decodable {
    var precipitation: Double?
}

struct HourlyForecast: Decodable {
    var dt : Int?
    var temperature: Double?
    var weather: [Weather]?
    
    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case temperature = "temp"
        case weather = "weather"
    }
}
