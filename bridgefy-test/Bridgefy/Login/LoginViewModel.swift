//
//  LoginViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation

struct LoginViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class LoginViewModel: ViewModelProtocol {
    
    typealias DataSource = LoginViewModelDataSource
    typealias Router = LoginRouter
    
    private(set) var context: Context
    private let dataSource: DataSource
    private let router: Router
    
    init(dataSource: LoginViewModelDataSource, router: LoginRouter) {
        self.context = dataSource.context
        self.dataSource = dataSource
        self.router = router
    }
}
