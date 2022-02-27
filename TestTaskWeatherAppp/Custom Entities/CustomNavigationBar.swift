//
//  CustomNavigationBar.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit
import PureLayout

class CustomNavigationBar: UIView {

    // MARK: - Private Data
    private let title = UILabel()
    private let gradientImageView = UIImageView()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public Methods
    func add(title: String?) {
        self.title.text = title
    }

    // MARK: - Private Methods
    private func setupView() {
        backgroundColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .black
        gradientImageView.image = UIImage(named: "ic_gradient")
        addSubview(title)
        addSubview(gradientImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        title.autoSetDimension(.height, toSize: 22)
        title.autoPinEdge(toSuperviewEdge: .top, withInset: 26)
        title.autoAlignAxis(toSuperviewAxis: .vertical)
        
        gradientImageView.autoSetDimension(.height, toSize: 4)
        gradientImageView.autoPinEdge(.bottom, to: .bottom, of: self)
        gradientImageView.autoPinEdge(.left, to: .left, of: self)
        gradientImageView.autoPinEdge(.right, to: .right, of: self)
    }
}
