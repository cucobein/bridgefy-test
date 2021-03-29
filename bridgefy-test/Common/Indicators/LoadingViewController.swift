//
//  LoadingViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit
import Lottie

class LoadingViewController: UIViewController {
    
    private let loadingView = AnimationView(frame: CGRect.zero)
    private let loadingLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.7)
        view.addSubview(loadingView)
        loadingView.setSize(100, 100)
        loadingView.center(to: view)
        setupLoadingLabel()
    }
    
    func configure(text: String?) {
        loadingLabel.text = text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.playAnimation(.loading)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingView.stop()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
}

private extension LoadingViewController {
    
    func setupLoadingLabel() {
        loadingLabel.font = UIFont.animosaBoldFont(withSize: 18)
        loadingLabel.textAlignment = .center
        loadingLabel.textColor = .lightGray
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingLabel)
        loadingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        loadingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: loadingLabel,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: loadingView,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 22)
        ])
    }
}
