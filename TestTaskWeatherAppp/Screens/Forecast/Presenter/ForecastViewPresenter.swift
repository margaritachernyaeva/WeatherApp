//
//  ForecastViewPresenter.swift
//  TestTaskWeatherAppp
//
//  Created by Chernyaeva Margarita on 26.02.22.
//

import Foundation

struct ForecastSection: CustomStringConvertible {
    var title: String? {
        let date = items.first?.date ?? Date()
        if isSameDay(date1: date, date2: Date()) {
            return NSLocalizedString("today_title", comment: "").uppercased()
        }
        return date.dayOfWeek()?.uppercased()
    }
    
    var description: String {
        return "name: " + (title ?? "") + ", items: \(items)"
    }
    
    var items: [(date: Date?, forecast: HourlyForecast)]
    
    private func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        return diff.day == 0
    }
}

class ForecastViewPresenter: ForecastViewPresenterProtocol {
    
    // MARK: - Public Data
    weak var view: ForecastViewControllerProtocol?
    
    // MARK: - Private Data
    private let dataManager: WeatherServiceProtocol
    private var forecastMap: ForecastMap?
    private var hourlyForecasts: [HourlyForecast] {
        let allItems = forecastMap?.hourly
        let itemsAtEvenIndices = allItems?.enumerated().compactMap { tuple in
          tuple.offset.isMultiple(of: 3) ? tuple.element : nil
        }
        return itemsAtEvenIndices ?? []
    }
    private var forecasts: [(date: Date?, forecast: HourlyForecast)] {
        return hourlyForecasts
            .map { (date: $0.dt?.toDate(), forecast: $0) }
    }
    private var sections = [ForecastSection]()
    
    // MARK: - Initialization
    init(view: ForecastViewControllerProtocol, dataManager: WeatherServiceProtocol) {
        self.view = view
        self.dataManager = dataManager
    }
    
    // MARK: - Public Methods
    func viewDidLoad() {
        guard dataManager.forecastMap != nil else {
            loadForecast()
            return
        }
        self.forecastMap = dataManager.forecastMap
        createSections()
    }
    
    func loadForecast() {
        dataManager.getWeatherForecast { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let forecastMap):
                self.forecastMap = forecastMap
                self.createSections()
                self.view?.updateUI()
            case .failure(let error):
                self.view?.showErrorAlert(error: error,
                                     description: CodeMarker(self, #function, #line),
                                     errorMessage: "Couldnt load forecast")
            }
        }
    }
    
    func getNavigationBarTitle() -> String? {
        return dataManager.getPlacemark()?.locality ?? ""
    }
    
    func cellCount(for section: Int) -> Int {
        return sections[safe: section]?.items.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func getCellModel(for indexPath: IndexPath) -> HourForecastCellModel {
        let forecastModel = sections[safe: indexPath.section]?.items[safe: indexPath.row]?.forecast
        let image = dataManager.getImage(stringUrl: forecastModel?.weather?.first?.iconURL ?? "")
        let time = forecastModel?.dt?.toDate()?.toHours()
        let forecastText = forecastModel?.weather?.first?.description
        let celsius = forecastModel?.temperature?.toTempratureInCelscious()
        let isSeparatorHidden = indexPath.row == sections[safe: indexPath.section]?.items.count ?? 0 - 1 /// checking if last
        let model = HourForecastCellModel(image: image, time: time, forecast: forecastText, celsius: celsius, isSeparatorHidden: isSeparatorHidden)
        return model
    }
    
    func getTitle(for section: Int) -> String? {
        return sections[safe: section]?.title
    }

    // MARK: - Private Methods
    private func createSections() {
        let groups = Dictionary(grouping: forecasts) { $0.date?.dayOfWeek() }
        print(groups)
        sections = groups.values.map { forecasts in
            var sortedForecasts = forecasts
            sortedForecasts.sort { (lForecast, rForecast) -> Bool in
                guard let leftDate =  lForecast.date,
                      let rightDate = rForecast.date else {
                    return false
                }
                return leftDate < rightDate
            }
            return ForecastSection(items: sortedForecasts)
        }
        sections.sort(by: {(itemL, itemR) -> Bool in
            if let leftDate = itemL.items.first?.date,
               let rightDate = itemR.items.first?.date {
                return leftDate < rightDate
            }
            return false
        })
    }
}
