//
//  UIViewController+Loading.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit

private var loadingWindow: UIWindow?

extension UIViewController {
    
    func displayLoadingView(withText: String? = nil) {
        if let window = (UIApplication.shared.windows.first { $0.rootViewController is LoadingViewController }) {
            window.makeKeyAndVisible()
            loadingWindow = window
        } else {
            let window = UIWindow(frame: UIApplication.shared.keyWindow!.frame)
            let loadingViewController = LoadingViewController()
            loadingViewController.configure(text: withText)
            window.rootViewController = loadingViewController
            window.windowLevel = .alert
            window.makeKeyAndVisible()
            loadingWindow = window
        }
    }
    
    func dismissLoadingView() {
        loadingWindow?.resignKey()
        loadingWindow = nil
    }
}
