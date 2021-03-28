//
//  CountriesViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation

struct CountriesViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class CountriesViewModel: ViewModelProtocol {
    
    typealias DataSource = CountriesViewModelDataSource
    typealias Router = CountriesRouter
    
    private(set) var context: Context
    private let dataSource: DataSource
    private let router: Router
    
    init(dataSource: CountriesViewModelDataSource, router: CountriesRouter) {
        self.context = dataSource.context
        self.dataSource = dataSource
        self.router = router
    }
}
