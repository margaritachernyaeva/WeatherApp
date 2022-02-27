//
//  UIView+AutoPinEdges.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

extension UIView {
    func autoPinEdgeToSuperviewLeftRightEdges() {
        autoPinEdge(toSuperviewEdge: .left)
        autoPinEdge(toSuperviewEdge: .right)
    }
}

