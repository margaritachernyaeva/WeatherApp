//
//  CodeDescription.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation

struct CodeDescription: CustomStringConvertible {

    // MARK: - Private Data
    private let codeDescription: String

    // MARK: - Public Data
    var description: String {
        return codeDescription
    }

    // MARK: - Initialization
    init(_ object: AnyObject, _ function: String, _ line: Int) {
        codeDescription = String(describing: object.self) + "." + function + ":\(line)"
    }
}
