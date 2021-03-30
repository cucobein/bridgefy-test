//
//  CountryDetailViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation

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
    private let router: Router
    
    init(dataSource: CountryDetailViewModelDataSource, router: CountryDetailRouter) {
        self.context = dataSource.context
        self.country = dataSource.country
        self.dataSource = dataSource
        self.countriesProvider = dataSource.context.countriesProvider
        self.router = router
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
        print(countryData)
    }
}
