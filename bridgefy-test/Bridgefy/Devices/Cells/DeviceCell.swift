//
//  DeviceCell.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 30/03/21.
//

import UIKit
import Bond

struct DeviceCellDataSource: ViewModelDataSourceProtocol {
    
    var context: Context
    let device: BLEDevice
}

final class DeviceCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var advertisementLabel: UILabel!
    @IBOutlet private weak var rssiLabel: UILabel!
    private var dataSource: DeviceCellDataSource!
    
    func configure(with dataSource: DeviceCellDataSource) {
        self.dataSource = dataSource
        nameLabel.text = "Device: \(dataSource.device.name ?? "N/A")"
        let keysValues = (dataSource.device.advertisementData.compactMap({ (key, value) -> String in
            return "\(key) -> \(value)"
        }) as Array).joined(separator: "\n")
        advertisementLabel.text = keysValues
        rssiLabel.text = "RSSI: \(dataSource.device.rssi)"
    }
}
