//
//  BluetoothProvider.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import Foundation
import Bond
import ReactiveKit
import CoreBluetooth

enum BLEStatus {
    case idle
    case scanning
}

class DevicesProvider: NSObject {
    
    private let apiService: ApiService
    private let centralManager = CBCentralManager(delegate: nil, queue: nil)
    let bleStatus = Observable<BLEStatus>(.idle)
    let devices = Observable<[BLEDevice]>([])
    
    init(apiService: ApiService) {
        self.apiService = apiService
        super.init()
        self.centralManager.delegate = self
    }
    
    func startScan(duration: Double) {
        guard bleStatus.value == .idle else { return }
        devices.value = []
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        bleStatus.value = .scanning
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.centralManager.stopScan()
            self.bleStatus.value = .idle
        }
    }
}

extension DevicesProvider: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("Is Powered Off.")
        case .poweredOn:
            print("Is Powered On.")
        case .unsupported:
            print("Is Unsupported.")
        case .unauthorized:
            print("Is Unauthorized.")
        case .unknown:
            print("Unknown")
        case .resetting:
            print("Resetting")
        @unknown default:
            print("Error")
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String: Any],
                        rssi RSSI: NSNumber) {
        guard devices.value.first(where: { device -> Bool in
            device.name == peripheral.name
        }) != nil else {
            var newList = devices.value
            newList.append(BLEDevice(name: peripheral.name,
                                     advertisementData: advertisementData,
                                     rssi: RSSI))
            devices.value = newList
            print(devices.value)
            return
        }
    }
}
