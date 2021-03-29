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

    @IBOutlet private weak var contentStackView: UIStackView!
    @IBOutlet private weak var loginButton: RoundedButton!
    
    private var viewModel: LoginViewModel!
    private let emailRow = InputRow()
    private let passwordRow = InputRow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViews()
    }
    
    func configure(with viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension LoginViewController {
    
    func configureUI() {
        let emailViewModel = InputRowViewModel(placeHolderText: "Email",
                                              selectedOption: viewModel.email,
                                              showableError: "Invalid Email input",
                                              maxCharCount: 24)
        emailViewModel.neededHeightForDisplay.bind(to: viewModel.minHeightNeeded)
        _ = viewModel.showEmailError.observeNext { (show) in
            self.emailRow.error(visible: show)
        }
        emailRow.configure(for: emailViewModel)
        contentStackView.insertArrangedSubview(emailRow, at: 0)
        
        let passwordViewModel = InputRowViewModel(placeHolderText: "Password",
                                                  selectedOption: viewModel.password,
                                                  showableError: "Invalid Password input",
                                                  maxCharCount: 24,
                                                  isSecureTextEntry: true)
        passwordViewModel.neededHeightForDisplay.bind(to: viewModel.minHeightNeeded)
        _ = viewModel.showPasswordError.observeNext { (show) in
            self.passwordRow.error(visible: show)
        }
        passwordRow.configure(for: passwordViewModel)
        contentStackView.insertArrangedSubview(passwordRow, at: 1)
    }
    
    func bindViews() {
        _ = loginButton.reactive.controlEvents(.touchUpInside).observeNext { [weak self] in
            guard let self = self else { return }
            self.viewModel.onLogin()
        }
    }
}
