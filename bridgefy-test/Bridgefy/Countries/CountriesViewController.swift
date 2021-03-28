//
//  CountriesViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

final class CountriesViewController: UIViewController, ViewControllerProtocol {
    
    typealias ViewModel = CountriesViewModel

    private var viewModel: CountriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViews()
    }
    
    func configure(with viewModel: CountriesViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension CountriesViewController {
    
    func configure() {
    }
    
    func bindViews() {
    }
}
