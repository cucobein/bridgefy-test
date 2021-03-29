//
//  CountryCell.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit
import AVKit
import Bond

struct CountryCellDataSource: ViewModelDataSourceProtocol {
    
    var context: Context
    let country: CountrySummary
}

final class CountryCell: UITableViewCell {
    
    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var alphaCodeLabel: UILabel!
    private var dataSource: CountryCellDataSource!
    private var imagesProvider: ImagesProvider!
    
    func configure(with dataSource: CountryCellDataSource) {
        self.dataSource = dataSource
        self.imagesProvider = dataSource.context.imagesProvider
        nameLabel.text = dataSource.country.name
        alphaCodeLabel.text = "\(dataSource.country.alpha2Code ?? "") / \(dataSource.country.alpha3Code ?? "")"
        loadImage()
    }
}

private extension CountryCell {
        
    func loadImage() {
        if let countryCode = dataSource.country.alpha2Code {
            imagesProvider.getFlagImage(countryCode: countryCode) { result in
                switch result {
                case .success(let image):
                    self.flagImageView.image = image
                case .failure: ()
                }
            }
        }
    }
}
