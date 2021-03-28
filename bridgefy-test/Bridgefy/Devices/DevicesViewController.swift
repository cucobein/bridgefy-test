//
//  DevicesViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

final class DevicesViewController: UIViewController, ViewControllerProtocol {
    
    typealias ViewModel = DevicesViewModel

    private var viewModel: DevicesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViews()
    }
    
    func configure(with viewModel: DevicesViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension DevicesViewController {
    
    func configure() {
    }
    
    func bindViews() {
    }
}
