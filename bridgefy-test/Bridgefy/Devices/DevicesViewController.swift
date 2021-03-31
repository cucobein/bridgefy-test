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
        navigationItem.rightBarButtonItem = .textBarButtonItem(title: "Scan", color: .bridgefyRed, tapHandler: {
            self.viewModel.startScan()
        })
    }
    func bindViews() {
        _ = viewModel.isScanning.observeNext { [weak self] in
            guard let self = self else { return }
            self.navigationItem.rightBarButtonItem?.title = $0 ? "In progress..." : "Scan"
        }
    }
}
