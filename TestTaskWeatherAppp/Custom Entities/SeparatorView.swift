//
//  SeparatorView.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import Foundation
import UIKit

class Separator: UIView {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .lightGray
        autoSetDimension(.height, toSize: 0.5)
    }
}
