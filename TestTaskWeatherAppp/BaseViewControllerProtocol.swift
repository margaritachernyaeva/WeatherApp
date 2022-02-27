//
//  BaseViewControllerProtocol.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

protocol BaseViewControllerProtocol: UIViewController {
    func updateUI()
}

extension BaseViewControllerProtocol {
    func updateUI() { }
    func setup(navigationBarView: CustomNavigationBar, withTitle title: String?) {
        navigationBarView.add(title: title)
        let navigationBarHeight: CGFloat = 70
        view.addSubview(navigationBarView)
        navigationBarView.autoSetDimension(.height, toSize: navigationBarHeight)
        navigationBarView.autoPinEdge(.top, to: .top, of: view)
        navigationBarView.autoPinEdge(.trailing, to: .trailing, of: view)
        navigationBarView.autoPinEdge(.leading, to: .leading, of: view)
    }
    
    
    func autoPinEdgeToSuperviewLeftRightEdges(_ view: UIView) {
        view.autoPinEdge(toSuperviewEdge: .left)
        view.autoPinEdge(toSuperviewEdge: .right)
    }
}
