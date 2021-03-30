//
//  CountryDetailViewController.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import UIKit
import Bond

final class CountryDetailViewController: UIViewController, ViewControllerProtocol {
    
    typealias ViewModel = CountryDetailViewModel

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nativeNameLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var mapImageView: UIImageView!
    @IBOutlet private weak var subregionLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var latlngLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var languagesLabel: UILabel!
    @IBOutlet private weak var callingCodesLabel: UILabel!
    @IBOutlet private weak var timezonesLabel: UILabel!
    @IBOutlet private weak var currenciesLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private var viewModel: CountryDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bindViews()
    }
    
    func configure(with viewModel: CountryDetailViewModel) {
        self.viewModel = viewModel
    }
}
   
private extension CountryDetailViewController {
    
    func configure() {
        navigationItem.leftBarButtonItem = .textBarButtonItem(title: "<", color: .bridgefyRed, tapHandler: {
            self.viewModel.goBack()
        })
        navigationItem.rightBarButtonItem = .textBarButtonItem(title: "Save", color: .bridgefyRed, tapHandler: {
            self.viewModel.toggleStorageState()
        })
        navigationItem.title = viewModel.country.name
        hidesBottomBarWhenPushed = true
        collectionView.register(UINib(nibName: "BorderCell", bundle: .main), forCellWithReuseIdentifier: "BorderCell")
    }
    
    func bindViews() {
        _ = viewModel.storageState.observeNext { [weak self] in
            guard let self = self else { return }
            switch $0 {
            case .stored:
                self.navigationItem.rightBarButtonItem?.title = "Delete"
            case .notStored:
                self.navigationItem.rightBarButtonItem?.title = "Save"
            }
        }
        _ = viewModel.flagImage.observeNext { [weak self] in
            if let image = $0 {
                self?.flagImageView.image = image
            }
        }
        _ = viewModel.nativeName.observeNext { [weak self] in
            self?.nativeNameLabel.text = $0
        }
        _ = viewModel.capital.observeNext { [weak self] in
            self?.capitalLabel.text = $0
        }
        _ = viewModel.mapImage.observeNext { [weak self] in
            if let image = $0 {
                self?.mapImageView.image = image
            }
        }
        _ = viewModel.subregion.observeNext { [weak self] in
            self?.subregionLabel.text = $0
        }
        _ = viewModel.area.observeNext { [weak self] in
            self?.areaLabel.text = $0
        }
        _ = viewModel.latlng.observeNext { [weak self] in
            self?.latlngLabel.text = $0
        }
        _ = viewModel.population.observeNext { [weak self] in
            self?.populationLabel.text = $0
        }
        _ = viewModel.languages.observeNext { [weak self] in
            self?.languagesLabel.text = $0
        }
        _ = viewModel.callingCodes.observeNext { [weak self] in
            self?.callingCodesLabel.text = $0
        }
        _ = viewModel.timezones.observeNext { [weak self] in
            self?.timezonesLabel.text = $0
        }
        _ = viewModel.currencies.observeNext { [weak self] in
            self?.currenciesLabel.text = $0
        }
        viewModel.borders.bind(to: collectionView, cellType: BorderCell.self) {
            $0.configure(with: $1)
        }
    }
}
