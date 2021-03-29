//
//  CountriesViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

final class CountriesViewController: UIViewController, ViewControllerProtocol {
    
    typealias ViewModel = CountriesViewModel

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var viewModel: CountriesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViews()
    }
    
    func configure(with viewModel: CountriesViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension CountriesViewController {
    
    func configure() {
        navigationItem.rightBarButtonItem = .textBarButtonItem(title: "", color: .bridgefyRed, tapHandler: {
            self.viewModel.toggleGroupingState()
        })
    }
    
    func bindViews() {
        _ = viewModel.groupingState.observeNext {
            if $0 == .grouped {
                self.navigationItem.rightBarButtonItem?.title = "Ungroup"
                self.searchBar.isHidden = true
            } else {
                self.navigationItem.rightBarButtonItem?.title = "Group"
                self.searchBar.isHidden = false
            }
        }
        
        viewModel.countries.bind(to: tableView, cellType: CountryCell.self) {
            $0.backgroundColor = .clear
            $0.configure(with: $1)
        }
    }
}
