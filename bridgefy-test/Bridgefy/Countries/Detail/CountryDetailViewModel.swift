//
//  CountryDetailViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation

struct CountryDetailViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class CountryDetailViewModel: ViewModelProtocol {
    
    typealias DataSource = CountryDetailViewModelDataSource
    typealias Router = CountryDetailRouter
    
    private(set) var context: Context
    private let dataSource: DataSource
    private let router: Router
    
    init(dataSource: CountryDetailViewModelDataSource, router: CountryDetailRouter) {
        self.context = dataSource.context
        self.dataSource = dataSource
        self.router = router
    }
}
