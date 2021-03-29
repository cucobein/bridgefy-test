//
//  TabBarViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import Foundation
import Bond

struct TabBarViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class TabBarViewModel: ViewModelProtocol {
    
    private let context: Context
    private let router: TabBarRouter
    
    let countriesDataSource: CountriesViewModelDataSource
    let devicesDatasource: DevicesViewModelDataSource
    
    init(dataSource: TabBarViewModelDataSource, router: TabBarRouter) {
        self.router = router
        context = dataSource.context
        countriesDataSource = CountriesViewModelDataSource(context: context)
        devicesDatasource = DevicesViewModelDataSource(context: context)
    }
}
