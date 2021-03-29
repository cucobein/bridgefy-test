//
//  BridgefyNavigationController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import UIKit

enum NavigationBarStyle {
    
    case clear
}

protocol ViewControllerNavigationStyle {
    
    var navigationBarStyle: NavigationBarStyle { get }
}

class BridgefyNavigationController: UINavigationController {

    static func navigationController() -> BridgefyNavigationController {
        let navController = BridgefyNavigationController()
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.tintColor = .white
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.animosaBoldFont(withSize: 17)
        ]
        navController.navigationBar.titleTextAttributes = textAttributes
        navController.delegate = navController
        return navController
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        viewControllers.last?.preferredStatusBarStyle ?? .default
    }
    
    func adjustNavigationBar(forViewController viewController: UIViewController) {
        if let viewControllerNavigationStyle = viewController as? ViewControllerNavigationStyle {
            adjustNavigationBar(forStyle: viewControllerNavigationStyle.navigationBarStyle)
        } else {
            adjustNavigationBar(forStyle: .clear)
        }
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension BridgefyNavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

extension BridgefyNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        adjustNavigationBar(forViewController: viewController)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func adjustNavigationBar(forStyle style: NavigationBarStyle) {
        navigationBar.barTintColor = .clear
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.animosaBoldFont(withSize: 17)
        ]
    }
}
