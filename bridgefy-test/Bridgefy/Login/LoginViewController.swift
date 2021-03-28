//
//  LoginViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

final class LoginViewController: UIViewController, ViewControllerProtocol {
    
    typealias ViewModel = LoginViewModel

    private var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViews()
    }
    
    func configure(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension LoginViewController {
    
    func configure() {
    }
    
    func bindViews() {
    }
}
