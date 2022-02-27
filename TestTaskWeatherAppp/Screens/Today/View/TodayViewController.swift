//
//  TodayViewController.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import UIKit

class TodayViewController: UIViewController, TodayViewControllerProtocol {

    // MARK: - Public Data
    var presenter: TodayViewPresenterProtocol!
    
    // MARK: - Private Data
    private let navigationBarView = CustomNavigationBar()
    private let todayWeatherImageView = UIImageView()
    private let locationNamelabel = UILabel()
    private let locationNameLabelStackView = UIStackView()
    private let forecastWeatherLabel = UILabel()
    private let firstGraySeparatorView = UIView()
    private var secondGraySeparator = UIView()
    private let humidityLabel = UILabel()
    private let precipitationLabel = UILabel()
    private let pressureLabel = UILabel()
    private let windSpeedLabel = UILabel()
    private let windDirection = UILabel()
    private let firstRowOfWeatherDescriptionStackView = UIStackView()
    private let secondRowOfWeatherDescriptionStackView = UIStackView()
    private let shareButton = UIButton()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
        setupViews()
        updateUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstGraySeparatorView.autoSetDimension(.width, toSize: forecastWeatherLabel.frame.width)
        secondGraySeparator.autoSetDimension(.width, toSize: forecastWeatherLabel.frame.width)
    }
    
    // MARK: - Actions
    @objc private func shareButtonTapped() {
        presenter.shareButtonTapped()
    }
    
    // MARK: - Public Methods
    func updateUI() {
        todayWeatherImageView.image = presenter.getTodayWeatherImage()
        locationNamelabel.text = presenter.getLocationNameText()
        forecastWeatherLabel.text = presenter.getCurrentWeatherText()
        humidityLabel.text = presenter.getHumidityText()
        precipitationLabel.text = presenter.getPrecipitationText()
        pressureLabel.text = presenter.getPressureText()
        windSpeedLabel.text = presenter.getWindSpeedText()
        windDirection.text = presenter.getWindDirectionText()
    }
    
    // MARK: - Private Methods
    private func setupViews() {
        setup(navigationBarView: navigationBarView, withTitle: "Today")
        setupTodayWeatherImageView()
        setupLocationLabel()
        setupForecastWeatherLabel()
        setupGreySeparatorView()
        setupWeatherDescriptionLabels()
        setupSecondGreySeparator()
        setupShareButton()
    }
    
    private func configureSeparatorView(_ view: UIView) {
        view.autoSetDimension(.height, toSize: 2)
        view.autoAlignAxis(toSuperviewAxis: .vertical)
        view.backgroundColor = .lightGray
    }
    
    private func setupSecondGreySeparator() {
        view.addSubview(secondGraySeparator)
        configureSeparatorView(secondGraySeparator)
        secondGraySeparator.autoPinEdge(.top, to: .bottom, of: secondRowOfWeatherDescriptionStackView, withOffset: 14)
        
    }
    
    private func setupShareButton() {
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(.orange, for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        view?.addSubview(shareButton)
        
        shareButton.autoPinEdge(toSuperviewSafeArea: .bottom, withInset: 20)
        shareButton.autoAlignAxis(toSuperviewAxis: .vertical)
        shareButton.autoSetDimension(.height, toSize: 24)
        
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    private func setupWeatherDescriptionLabels() {
        let labelArray = [humidityLabel, precipitationLabel, pressureLabel, windSpeedLabel, windDirection]
        let imageArray = [UIImage(named: "ic_humidity"), UIImage(named: "ic_rain"), UIImage(named: "ic_thermometr"), UIImage(named: "ic_wind"), UIImage(named: "ic_compas")]
        labelArray.forEach { $0.font = UIFont.systemFont(ofSize: 14) }
        var stackViewArray = [UIStackView]()
        for (index, label) in labelArray.enumerated() {
            let stackView = UIStackView()
            let imageView = UIImageView(image: imageArray[safe: index] ?? UIImage())
            imageView.autoSetDimension(.height, toSize: 30)
            imageView.autoSetDimension(.width, toSize: 30)
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(label)
            stackView.spacing = 2
            stackView.axis = .vertical
            stackView.alignment = .center
            stackViewArray.append(stackView)
        }
        for (index, stackView) in stackViewArray.enumerated() where index >= 0 && index <= 2  {
            firstRowOfWeatherDescriptionStackView.addArrangedSubview(stackView)
        }
        for (index, stackView) in stackViewArray.enumerated() where index > 2 && index <= 4 {
            secondRowOfWeatherDescriptionStackView.addArrangedSubview(stackView)
        }

        view.addSubview(firstRowOfWeatherDescriptionStackView)
        view.addSubview(secondRowOfWeatherDescriptionStackView)
        
        firstRowOfWeatherDescriptionStackView.autoPinEdge(.top, to: .bottom, of: firstGraySeparatorView, withOffset: 14)
        secondRowOfWeatherDescriptionStackView.autoPinEdge(.top, to: .bottom, of: firstRowOfWeatherDescriptionStackView, withOffset: 14)
        
        setupRowStackView(firstRowOfWeatherDescriptionStackView)
        setupRowStackView(secondRowOfWeatherDescriptionStackView)
    }
    
    private func setupRowStackView(_ stackView: UIStackView) {
        stackView.autoAlignAxis(toSuperviewAxis: .vertical)
        stackView.autoSetDimension(.height, toSize: 54)
        stackView.axis = .horizontal
        stackView.spacing = 14
    }
    
    private func setupForecastWeatherLabel() {
        forecastWeatherLabel.font = UIFont.systemFont(ofSize: 20)
        forecastWeatherLabel.textColor = .blue
        view.addSubview(forecastWeatherLabel)
        
        forecastWeatherLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        forecastWeatherLabel.autoPinEdge(.top, to: .bottom, of: locationNameLabelStackView, withOffset: 20)
    }
    
    private func setupLocationLabel() {
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "ic_vector")
        locationNamelabel.textAlignment = .left
        
        locationNameLabelStackView.addArrangedSubview(locationImageView)
        locationNameLabelStackView.addArrangedSubview(locationNamelabel)
        
        view.addSubview(locationNameLabelStackView)
        
        locationImageView.autoSetDimension(.width, toSize: 14)
        locationNameLabelStackView.autoSetDimension(.height, toSize: 14)
        locationNameLabelStackView.distribution = .equalCentering
        locationNameLabelStackView.alignment = .center
        locationNameLabelStackView.spacing = 4
        locationNameLabelStackView.autoAlignAxis(.vertical, toSameAxisOf: todayWeatherImageView)
        locationNameLabelStackView.autoPinEdge(.top, to: .bottom, of: todayWeatherImageView, withOffset: 20)
    }
    
    private func setupGreySeparatorView() {
        view.addSubview(firstGraySeparatorView)
        configureSeparatorView(firstGraySeparatorView)
        firstGraySeparatorView.autoPinEdge(.top, to: .bottom, of: forecastWeatherLabel, withOffset: 10)
    }
    
    private func setupTodayWeatherImageView() {
        view.addSubview(todayWeatherImageView)
        todayWeatherImageView.autoSetDimension(.height, toSize: 100)
        todayWeatherImageView.autoSetDimension(.width, toSize: 100)
        todayWeatherImageView.autoPinEdge(.top, to: .bottom, of: navigationBarView, withOffset: 30)
        todayWeatherImageView.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
