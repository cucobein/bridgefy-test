//
//  TabBarRouter.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit

final class TabBarRouter: RouterProtocol {
    
    internal weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
