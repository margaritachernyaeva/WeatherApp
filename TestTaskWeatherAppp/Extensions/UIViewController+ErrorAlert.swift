//
//  UIViewController+ErrorAlert.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 27.02.22.
//

import Foundation
import UIKit

extension UIViewController {

    func showErrorAlertWithLog(error: Error, description: CodeMarker, errorMessage: String) {
        print("❗️❗️❗️❗️", String(describing: error), description)
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(errorMessage: String) {
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
