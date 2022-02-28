//
//  CommonError.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation

enum CommonError: Error {
    case nilValue(String)
    case locationFail
    case locationDetermineRestricted
    case unknownError
    
    var message: String {
        switch self {
        case .nilValue(let value):
            return "Nil value for \"\(value)\""
        case .locationFail:
            return "Something wrong while updating location"
        case .locationDetermineRestricted:
            return "Geolocation is off. Please turn it on to get app work correctly"
        case .unknownError:
            return "Something went wrong"
        }
    }
}
