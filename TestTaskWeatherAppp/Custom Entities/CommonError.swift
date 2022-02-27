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
    
    var description: String {
        switch self {
        case .nilValue(let value):
            return "Nil value for \"\(value)\""
        case .locationFail:
            return "Something wrong while updating location"
        }
    }
}
