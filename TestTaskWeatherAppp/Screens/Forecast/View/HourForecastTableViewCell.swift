//
//  HourForecastTableViewCell.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

struct HourForecastCellModel {
    var image: UIImage?
    var time: String?
    var forecast: String?
    var celsius: String?
    var isSeparatorHidden: Bool
}

class HourForecastTableViewCell: UITableViewCell {
    
    static let cellIdentificator = "HourForecastCell"
    
    private let forecastImageView = UIImageView()
    private let timeLabel = UILabel()
    private let forecastTextLabel = UILabel()
    private let celsiusLabel = UILabel()
    private let infoStackView = UIStackView()
    private let separator = UIView()
    
    //MARK: -  Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(forecastImageView)
        contentView.addSubview(infoStackView)
        contentView.addSubview(celsiusLabel)
        layoutIfNeeded()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(_ model: HourForecastCellModel) {
        forecastImageView.image = model.image
        timeLabel.text = model.time
        forecastTextLabel.text = model.forecast
        celsiusLabel.text = model.celsius
        separator.isHidden = model.isSeparatorHidden
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        forecastImageView.image = nil
        timeLabel.text = nil
        forecastTextLabel.text = nil
        celsiusLabel.text = nil
        
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        setupImageView()
        setupCelsiusLabel()
        setupInfoStackView()
        setupSeparator()
    }
    
    private func setupSeparator() {
        contentView.addSubview(separator)
        separator.backgroundColor = .lightGray
        separator.autoSetDimension(.height, toSize: 0.5)
        separator.autoPinEdge(.bottom, to: .bottom, of: contentView)
        separator.autoPinEdge(.right, to: .right, of: contentView)
        separator.autoConstrainAttribute(.left, to: .left, of: infoStackView)
    }
    
    private func setupCelsiusLabel() {
        celsiusLabel.autoMatch(.height, to: .height, of: forecastImageView)
        celsiusLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -14)
        celsiusLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        celsiusLabel.autoPinEdge(.left, to: .right, of: infoStackView, withOffset: 14)
        celsiusLabel.textAlignment = .right
        celsiusLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private func setupInfoStackView() {
        infoStackView.addArrangedSubview(timeLabel)
        infoStackView.addArrangedSubview(forecastTextLabel)
                
        infoStackView.spacing = 4
        infoStackView.axis = .vertical
        infoStackView.autoPinEdge(.left, to: .right, of: forecastImageView, withOffset: 10)
        infoStackView.autoAlignAxis(toSuperviewAxis: .horizontal)
        infoStackView.autoMatch(.height, to: .height, of: forecastImageView)
    }
    
    private func setupImageView() {
        forecastImageView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 14)
        forecastImageView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -14)
        forecastImageView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 14)
        forecastImageView.autoMatch(.width, to: .height, of: forecastImageView, withMultiplier: 1)
    }
}
