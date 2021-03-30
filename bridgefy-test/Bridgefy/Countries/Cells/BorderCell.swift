//
//  BorderCell.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 30/03/21.
//

import UIKit
import Bond

struct BorderCellDataSource: ViewModelDataSourceProtocol {
    
    var context: Context
    let countryCode: String
}

final class BorderCell: UICollectionViewCell {
    
    @IBOutlet private weak var flagLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private var dataSource: BorderCellDataSource!
    
    func configure(with dataSource: BorderCellDataSource) {
        self.dataSource = dataSource
        var flag = dataSource.countryCode.flagEmoji()
        _ = flag.removeLast()
        flagLabel.text = flag
        nameLabel.text = dataSource.countryCode.countryName()
    }
}
