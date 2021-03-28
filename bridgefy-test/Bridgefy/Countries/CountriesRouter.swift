//
//  CountriesRouter.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit

final class CountriesRouter: RouterProtocol {
    
    internal weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
