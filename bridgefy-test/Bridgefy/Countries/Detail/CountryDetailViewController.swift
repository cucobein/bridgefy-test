//
//  CountryDetailViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

final class CountryDetailViewController: UIViewController, ViewControllerProtocol {
    
    typealias ViewModel = CountryDetailViewModel

    private var viewModel: CountryDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViews()
    }
    
    func configure(with viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension CountryDetailViewController {
    
    func configure() {
    }
    
    func bindViews() {
    }
}
