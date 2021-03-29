//
//  TabBarViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit

final class TabBarViewController: UITabBarController, ViewControllerProtocol {
    
    typealias ViewModel = TabBarViewModel
    
    private var tabViewControllers: [UIViewController] = []
    private var viewModel: TabBarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(with viewModel: TabBarViewModel) {
        delegate = self
        self.viewModel = viewModel
        addChilds()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         .lightContent
    }
    
    func selectTabAt(index: Int) {
        selectedIndex = index
        refreshNavigationBar()
    }
}

extension TabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        AlphaTransition()
    }
}

private extension TabBarViewController {
    
    func refreshNavigationBar() {
        if let viewController = selectedViewController {
            guard let navigationController = navigationController as? BridgefyNavigationController else { return }
            navigationController.adjustNavigationBar(forViewController: viewController)
            UIView.animate(withDuration: 1) {
                self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem
                self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem
                self.title = viewController.title
            }
        }
    }
}

private extension TabBarViewController {
    
    func addChilds() {
        let countriesViewController = CountriesBuilder.build(with: viewModel.countriesDataSource)
        let devicesViewController = DevicesBuilder.build(with: viewModel.devicesDatasource)
        tabViewControllers = [countriesViewController, devicesViewController]
    }
    
    func configure() {
        let unselectedTextAtributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: UIFont.animosaBoldFont(withSize: 12)]
        let selectedTextAtributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.bridgefyRed, .font: UIFont.animosaBoldFont(withSize: 12)]
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = UIColor.bridgefyRed
        setViewControllers(tabViewControllers, animated: false)
        viewControllers?.forEach {
            $0.tabBarItem.setTitleTextAttributes(unselectedTextAtributes, for: .normal)
            $0.tabBarItem.setTitleTextAttributes(selectedTextAtributes, for: .selected)
            $0.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -4)
        }
    }
}
