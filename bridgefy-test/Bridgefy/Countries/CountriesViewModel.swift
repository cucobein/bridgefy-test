//
//  CountriesViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation
import Bond
import ReactiveKit

struct CountriesViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

enum CountriesGroupingState {
    case grouped
    case ungrouped
}

final class CountriesViewModel: ViewModelProtocol {
    
    typealias DataSource = CountriesViewModelDataSource
    typealias Router = CountriesRouter
    
    private(set) var context: Context
    private let dataSource: DataSource
    private let countriesProvider: CountriesProvider
    private let router: CountriesRouter
    let countries = MutableObservableArray<CountryCellDataSource>([])
    var groupingState = Observable<CountriesGroupingState>(.ungrouped)
    
    init(dataSource: CountriesViewModelDataSource, router: CountriesRouter) {
        self.context = dataSource.context
        self.dataSource = dataSource
        self.countriesProvider = dataSource.context.countriesProvider
        self.router = router
        fetchData()
    }
    
    func toggleGroupingState() {
        groupingState.value = groupingState.value == .grouped ? .ungrouped : .grouped
    }
    
    func onSelectedCountry(row: Int) {
        if let countryCode = countries[row].country.alpha2Code {
            router.routeToCountryDetail(dataSource: CountryDetailViewModelDataSource(context: context,
                                                                                     countryCode: countryCode))
        }
    }
}

private extension CountriesViewModel {
    
    func fetchData() {
        router.displayLoadingIndicator()
        countriesProvider.fetchCountries { [weak self] (result) in
            guard let self = self else { return }
            self.router.hideLoadingIndicator()
            switch result {
            case .success(let countries):
                if let countries = countries {
                    let countries = countries.map({ country -> CountryCellDataSource in
                        return CountryCellDataSource(context: self.context, country: country)
                    })
                    self.countries.replace(with: countries)
                }
            case .failure: ()
            }
        }
    }
}
