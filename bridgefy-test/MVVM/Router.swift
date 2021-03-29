//
//  Router.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import UIKit

enum TabBarSectionIndex: Int {
    case countries = 0
    case devices = 1
}

protocol RouterProtocol {
    
    var viewController: UIViewController? { get }
    func routeBack()
    init(viewController: UIViewController)
}

extension RouterProtocol {
    
    var navigationController: BridgefyNavigationController? {
        return viewController?.navigationController as? BridgefyNavigationController
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func push(viewController: UIViewController, isAlphaTransition: Bool = false) {
        guard isAlphaTransition else {
            self.viewController?.navigationController?.delegate = nil
            self.viewController?.navigationController?.pushViewController(viewController, animated: true)
            return
        }
        let delegate = NavigationDelegate()
        self.viewController?.navigationController?.delegate = delegate
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func displayLoadingIndicator() {
        viewController?.displayLoadingView(withText: "Loading...")
    }
    
    func hideLoadingIndicator() {
        viewController?.dismissLoadingView()
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        viewController?.present(alert, animated: true)
    }
    
    func routetoDashboard(with viewModelDataSource: TabBarViewModelDataSource) {
        guard let navigationController = viewController?.navigationController else { return }
        if navigationController.viewControllers.first is TabBarViewController {
            navigationController.popToRootViewController(animated: true)
        } else {
            let dashboard = TabBarBuilder.build(with: viewModelDataSource)
            navigationController.viewControllers = [dashboard, viewController!]
            navigationController.popViewController(animated: true)
        }
    }
}
