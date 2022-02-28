//
//  ForecastViewController.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

class ForecastViewController: UIViewController, ForecastViewControllerProtocol, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Public Data
    var presenter: ForecastViewPresenterProtocol!
    
    // MARK: - Private Data
    private let navigationBarView = CustomNavigationBar()
    private let tableView = UITableView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view?.backgroundColor = .orange
        presenter.viewDidLoad()
        setupViews()
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    private func setupViews() {
        setup(navigationBarView: navigationBarView, withTitle: presenter.getNavigationBarTitle())
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HourForecastTableViewCell.self, forCellReuseIdentifier: HourForecastTableViewCell.cellIdentificator)
        tableView.rowHeight = 70
        tableView.sectionHeaderTopPadding = 0.0

        view.addSubview(tableView)
        tableView.autoPinEdge(.top, to: .bottom, of: navigationBarView)
        tableView.autoPinEdge(.left, to: .left, of: view)
        tableView.autoPinEdge(.right, to: .right, of: view)
        tableView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        tableView.separatorStyle = .none
    }
}
    
    // MARK: - UITableViewDelegate && UITableViewDataSource
extension ForecastViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        let topSeparator = Separator()
        let bottomSeparator = Separator()
        let title = UILabel()
        view.addSubview(topSeparator)
        view.addSubview(bottomSeparator)
        view.addSubview(title)
        title.text = presenter.getTitle(for: section)
        title.textColor = .gray
        title.autoPinEdge(.left, to: .left, of: view, withOffset: 16)
        title.autoAlignAxis(toSuperviewAxis: .horizontal)
        topSeparator.autoPinEdgeToSuperviewLeftRightEdges()
        bottomSeparator.autoPinEdgeToSuperviewLeftRightEdges()
        topSeparator.autoPinEdge(toSuperviewEdge: .top)
        bottomSeparator.autoPinEdge(toSuperviewEdge: .bottom)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HourForecastTableViewCell.cellIdentificator, for: indexPath) as? HourForecastTableViewCell {
            cell.configure(presenter.getCellModel(for: indexPath))
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.cellCount(for: section)
    }
}
