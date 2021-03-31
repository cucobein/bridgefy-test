//
//  LoginViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

struct LoginViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class LoginViewModel: ViewModelProtocol {
    
    typealias DataSource = LoginViewModelDataSource
    typealias Router = LoginRouter
    
    private(set) var context: Context
    private(set) var authenticationProvider: AuthenticationProvider
    private let dataSource: DataSource
    private let router: Router
    
    let minHeightNeeded = Observable<CGFloat>(0)
    //let email = Observable<String?>("challenge@bridgefy.me")
    //let password = Observable<String?>("P@$$w0rD!")
    let email = Observable<String?>("")
    let password = Observable<String?>("")
    let showEmailError = Observable<Bool>(false)
    let showPasswordError = Observable<Bool>(false)
    init(dataSource: LoginViewModelDataSource, router: LoginRouter) {
        self.context = dataSource.context
        self.authenticationProvider = dataSource.context.authenticationProvider
        self.dataSource = dataSource
        self.router = router
    }
    
    func onLogin() {
        showEmailError.value = false
        showPasswordError.value = false
        guard let email = email.value,
              email.isEmail else {
            showEmailError.value = true
            return
        }
        guard let password = password.value,
              !password.isEmpty else {
            showPasswordError.value = true
            return
        }
        if !showEmailError.value && !showPasswordError.value {
            router.displayLoadingIndicator()
            authenticationProvider.login(email: email,
                                         password: password) { result in
                self.router.hideLoadingIndicator()
                switch result {
                case .success: self.router.routetoDashboard(with: self.tabBarViewModelDataSource)
                case .failure: self.router.displayAlert(title: "Error", message: "Invalid username or password.")
                }
            }
        }
    }
}

private extension LoginViewModel {

    var tabBarViewModelDataSource: TabBarViewModelDataSource {
        TabBarViewModelDataSource(context: context)
    }
}
