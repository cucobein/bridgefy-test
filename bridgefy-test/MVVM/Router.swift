//
//  Router.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 26/03/21.
//

import UIKit

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
}
