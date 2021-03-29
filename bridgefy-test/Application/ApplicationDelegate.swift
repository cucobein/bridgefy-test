//
//  ApplicationDelegate.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 29/03/21.
//

import UIKit

final class NavigationDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = AlphaTransition()
        transition.duration = 0.3
        return transition
    }
}
