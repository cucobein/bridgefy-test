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
    @IBOutlet private weak var groupedTableView: UITableView!
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
                self.groupedTableView.isHidden = false
                self.tableView.isHidden = true
            } else {
                self.navigationItem.rightBarButtonItem?.title = "Group"
                self.searchBar.isHidden = false
                self.groupedTableView.isHidden = true
                self.tableView.isHidden = false
            }
        }
        
        _ = searchBar.reactive.text.observeNext { [weak self] string in
            guard let self = self else { return }
            if let string = string {
                self.viewModel.filterCountries(filter: string)
            }
        }
        
        viewModel.countries.bind(to: tableView, cellType: CountryCell.self) {
            $0.configure(with: $1)
        }
        
        viewModel.groupedCountries.bind(to: groupedTableView, cellType: CountryCell.self) {
            $0.configure(with: $1)
        }
        
        _ = tableView.reactive.selectedRowIndexPath.observeNext { [weak self] indexPath in
            self?.viewModel.onSelectedCountry(row: indexPath.row)
        }
        
        _ = groupedTableView.reactive.selectedRowIndexPath.observeNext { [weak self] indexPath in            self?.viewModel.onSelectedCountry(section: indexPath.section, row: indexPath.row)
        }
    }
}

extension CountriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !viewModel.groupedCountries.collection[sectionAt: section].items.isEmpty,
           let region = viewModel.groupedCountries.collection[sectionAt: section].items[0].country.region else {
            let view = ClearanceHeaderView()
            view.set(title: "N/A")
            return view
        }
        let view = ClearanceHeaderView()
        view.set(title: region)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50.0 }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .white
    }
}
