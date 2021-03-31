//
//  DevicesViewModel.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 27/03/21.
//

import Foundation
import Bond
import ReactiveKit

struct DevicesViewModelDataSource: ViewModelDataSourceProtocol {
    
    let context: Context
}

final class DevicesViewModel: ViewModelProtocol {
    
    typealias DataSource = DevicesViewModelDataSource
    typealias Router = DevicesRouter
    
    private(set) var context: Context
    private let dataSource: DataSource
    private let devicesProvider: DevicesProvider
    private let router: Router
    let isScanning = Observable<Bool>(false)
    let devices = Observable<[DeviceCellDataSource]>([])
    
    init(dataSource: DevicesViewModelDataSource, router: DevicesRouter) {
        self.context = dataSource.context
        self.dataSource = dataSource
        self.devicesProvider = dataSource.context.devicesProvider
        self.router = router
        bind()
    }
    
    func startScan() {
        devicesProvider.startScan(duration: 30)
    }
    
    func bind() {
        _ = devicesProvider.bleStatus.observeNext { [weak self] in
            switch $0 {
            case .idle: self?.isScanning.value = false
            case .scanning: self?.isScanning.value = true
            }
        }
        _ = devicesProvider.devices.observeNext { devs in
            self.devices.value = devs.map { device -> DeviceCellDataSource in
                return DeviceCellDataSource(context: self.context, device: device)
            }
        }
    }
}
