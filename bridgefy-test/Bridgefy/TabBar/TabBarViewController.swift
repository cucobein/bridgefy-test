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

// MARK: Tab Bar Delegate Methods

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        trackTabBarEvent(for: viewController.tabBarItem.title ?? "")
        return true
    }

    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        AlphaTransition()
    }
}

// MARK: Refreshing Navigation Bar

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

// MARK: Analytics

private extension TabBarViewController {
    
    func trackTabBarEvent(for itemTitle: String) {
//        var selectedOption = ""
//        switch itemTitle {
//        case "INICIO":
//            selectedOption = "home"
//        case "OPCIONES":
//            selectedOption = "options"
//        case "VENDER":
//            selectedOption = "sell"
//        default:
//            break
//        }
//
//        if !selectedOption.isEmpty {
//            AnalyticsController.trackEvent(.navigationBar,
//                                           parameters: [.custom("optionSelected", selectedOption)])
//        }
    }
}

// MARK: Bond functions

private extension TabBarViewController {
    
    func addChilds() {
        let countriesViewController = CountriesBuilder.build(with: viewModel.countriesDataSource)
        let devicesViewController = DevicesBuilder.build(with: viewModel.devicesDatasource)
        tabViewControllers = [countriesViewController, devicesViewController]
    }
    
    func configure() {
        let unselectedTextAtributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: UIFont.animosaBoldFont(withSize: 9)]
        let selectedTextAtributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.bridgefyRed, .font: UIFont.animosaBoldFont(withSize: 9)]
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
