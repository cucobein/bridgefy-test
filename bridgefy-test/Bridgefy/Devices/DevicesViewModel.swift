//
//  DevicesViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation

struct DevicesViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class DevicesViewModel: ViewModelProtocol {
    
    typealias DataSource = DevicesViewModelDataSource
    typealias Router = DevicesRouter
    
    private(set) var context: Context
    private let dataSource: DataSource
    private let router: Router
    
    init(dataSource: DevicesViewModelDataSource, router: DevicesRouter) {
        self.context = dataSource.context
        self.dataSource = dataSource
        self.router = router
    }
}
