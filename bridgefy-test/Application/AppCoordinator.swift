//
//  AppCoordinator.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import UIKit

class AppCoordinator {
    
    private let apiService = ApiService()
    private(set) lazy var context: Context = {
        Context(apiService: apiService)
    }()
    
    func initialize(on window: UIWindow) {
        startApplication(on: window)
    }
}

extension AppCoordinator {
    
    func startApplication(on window: UIWindow) {
        let navigationController = BridgefyNavigationController.navigationController()
        let loginViewController = LoginBuilder.build(with: LoginViewModelDataSource(context: context))
        navigationController.viewControllers = [loginViewController]
        navigationController.popViewController(animated: false)
    }
}
