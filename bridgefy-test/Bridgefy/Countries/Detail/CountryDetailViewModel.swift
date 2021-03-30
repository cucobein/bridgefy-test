//
//  CountryDetailViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

struct CountryDetailViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
    let country: CountrySummary
}

final class CountryDetailViewModel: ViewModelProtocol {
    
    typealias DataSource = CountryDetailViewModelDataSource
    typealias Router = CountryDetailRouter
    
    private(set) var context: Context
    private(set) var country: CountrySummary
    private let dataSource: DataSource
    private let countriesProvider: CountriesProvider
    private let imagesProvider: ImagesProvider
    private let router: Router
    private let numberFormatter = NumberFormatter()
    let flagImage = Observable<UIImage?>(nil)
    let nativeName = Observable<String?>(nil)
    let capital = Observable<String?>(nil)
    let mapImage = Observable<UIImage?>(nil)
    let subregion = Observable<String?>(nil)
    let area = Observable<String?>(nil)
    let latlng = Observable<String?>(nil)
    let population = Observable<String?>(nil)
    let languages = Observable<String?>(nil)
    let callingCodes = Observable<String?>(nil)
    let timezones = Observable<String?>(nil)
    let currencies = Observable<String?>(nil)
    let borders = MutableObservableArray<BorderCellDataSource>([])

    init(dataSource: CountryDetailViewModelDataSource, router: CountryDetailRouter) {
        self.context = dataSource.context
        self.country = dataSource.country
        self.dataSource = dataSource
        self.countriesProvider = dataSource.context.countriesProvider
        self.imagesProvider = dataSource.context.imagesProvider
        self.router = router
        numberFormatter.numberStyle = .decimal
        fetchData()
    }
    
    func goBack() {
        router.routeBack()
    }
}

private extension CountryDetailViewModel {
    
    func fetchData() {
        guard let countryCode = country.alpha2Code else { return }
        router.displayLoadingIndicator()
        countriesProvider.fetchCountry(countryCode: countryCode) { result in
            self.router.hideLoadingIndicator()
            switch result {
            case .success(let countryData): self.setupData(countryData: countryData)
            case .failure: ()
            }
        }
    }
    
    func setupData(countryData: CountryDetail) {
        loadImage()
        nativeName.value = countryData.nativeName
        capital.value = countryData.capital
        if let countryCode = countryData.alpha3Code {
            mapImage.value = UIImage(named: countryCode)
        }
        subregion.value = countryData.subregion
        area.value = "\(numberFormatter.string(from: NSNumber(value: countryData.area ?? 0)) ?? "-") km²"
        if let latitudeLongitude = countryData.latlng, latitudeLongitude.count == 2 {
            latlng.value = "(\(latitudeLongitude[0]), \(latitudeLongitude[1]))"
        } else {
            latlng.value = "(-, -)"
        }
        population.value = "\(numberFormatter.string(from: NSNumber(value: countryData.population ?? 0)) ?? "-")"
        if let langs = countryData.languages {
            languages.value = langs.map { $0.languageName() }.joined(separator: ", ")
        }
        if let codes = countryData.callingCodes {
            callingCodes.value = codes.joined(separator: ", ")
        }
        if let times = countryData.timezones {
            timezones.value = times.joined(separator: "\n")
        }
        if let currs = countryData.currencies {
            currencies.value = currs.map { ($0.currencyName() ?? "") }.joined(separator: ", ")
        }
        if let bord = countryData.borders {
            let borderList = bord.map({ countryCode -> BorderCellDataSource in
                return BorderCellDataSource(context: context, countryCode: countryCode)
            })
            borders.replace(with: borderList)
        }
    }
    
    func loadImage() {
        if let countryCode = dataSource.country.alpha2Code {
            imagesProvider.getFlagImage(countryCode: countryCode) { result in
                switch result {
                case .success(let image):
                    self.flagImage.value = image
                case .failure: ()
                }
            }
        }
    }
}
