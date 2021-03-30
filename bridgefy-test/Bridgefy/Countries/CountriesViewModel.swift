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
    private var countriesData = [CountrySummary]()
    let countries = MutableObservableArray<CountryCellDataSource>([])
    let groupedCountries = MutableObservableArray2D<String, CountryCellDataSource>(Array2D<String, CountryCellDataSource>())
    let groupingState = Observable<CountriesGroupingState>(.ungrouped)
    
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
    
    func filterCountries(filter: String) {
        guard !filter.isEmpty else {
            refreshCountriesDataSource(countryList: countriesData)
            return
        }
        let filteredCountries = countriesData.filter { country -> Bool in
            guard let countryName = country.name else { return false }
            return countryName.lowercased().contains(filter.lowercased())
        }
        refreshCountriesDataSource(countryList: filteredCountries)
    }
    
    func onSelectedCountry(row: Int) {
        let country = countries[row].country
        router.routeToCountryDetail(dataSource: CountryDetailViewModelDataSource(context: context,
                                                                                 country: country))
    }
    
    func onSelectedCountry(section: Int, row: Int) {
        let country = groupedCountries[sectionAt: section].items[row].country
        router.routeToCountryDetail(dataSource: CountryDetailViewModelDataSource(context: context,
                                                                                 country: country))
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
                    // Ungrouped data
                    self.countriesData = countries
                    let countries = countries.map({ country -> CountryCellDataSource in
                        return CountryCellDataSource(context: self.context, country: country)
                    })
                    self.countries.replace(with: countries)
                    // Grouped data
                    let sortedCountries = countries.sorted {
                        ($0.country.region ?? "N/A") < ($1.country.region ?? "N/A")
                    }
                    let countriesDictionary = Dictionary(grouping: sortedCountries, by: { (element: CountryCellDataSource) in
                        element.country.region
                    })
                    var countries2DArray = Array2D<String, CountryCellDataSource>()
                    var index = 0
                    for (area, countries) in countriesDictionary {
                        if let area = area, !countries.isEmpty {
                            countries2DArray.appendSection(area)
                            for country in countries { countries2DArray.appendItem(country, toSectionAt: index) }
                            index += 1
                        }
                    }
                    self.groupedCountries.replace(with: countries2DArray)
                }
            case .failure: ()
            }
        }
    }
    
    private func refreshCountriesDataSource(countryList: [CountrySummary]) {
        let countries = countryList.map({ country -> CountryCellDataSource in
            return CountryCellDataSource(context: self.context, country: country)
        })
        self.countries.replace(with: countries)
    }
}
