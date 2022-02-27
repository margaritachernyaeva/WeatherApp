//
//  UIView+addShadow.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 1
    }
}
