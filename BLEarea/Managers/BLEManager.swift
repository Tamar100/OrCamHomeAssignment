//
//  BLEManager.swift
//  BLEarea
//
//  Created by Tamar on 25/11/2019.
//  Copyright © 2019 Levi. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol UpdateBLEDevicesDelegate:class{
    func bleDevicesUpdate()
}

class BLEManager:NSObject {
    
    static let sharedInstance = BLEManager()
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    
    private var bluethoothON = false
    private var isScan = false
    
    weak var delegate:UpdateBLEDevicesDelegate!
    
    var bleDevices = [Device]()
    
    func setup(){
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
}

extension BLEManager:CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state != .poweredOn {
            bluethoothON = false
            if isScan{
                showAlertConnectToBluetooth()
            }
        } else {
            bluethoothON = true
            if isScan{
                centralManager.scanForPeripherals(withServices: nil, options: nil)
            }
        }
    }
    
    func centralManagerScan(){
        if !bluethoothON{
            showAlertConnectToBluetooth()
        }else{
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            isScan = true
        }
    }
    
    func entralManagerStopScan(){
        centralManager.stopScan()
        isScan = false
        bleDevices.removeAll()
    }
    
    func showAlertConnectToBluetooth(){
        UIAlertController().showAlertView(title: "Warning", msg: "Turn on the bluetooth", okButtonTitle: "Settings") {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        }
    }
}

extension BLEManager: CBPeripheralDelegate{
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        //If the device was present on the list it is only updated and not attached again
        if let index = bleDevices.firstIndex(where: {$0.uuid == peripheral.identifier.uuidString}){
            bleDevices[index].name = peripheral.name
            bleDevices[index].state = peripheral.state.stringRepresentation
            bleDevices[index].rssi = RSSI.intValue
        }else{
            bleDevices.append(Device(_name: peripheral.name, _uuid: peripheral.identifier.uuidString, _state: peripheral.state.stringRepresentation, _rssi: RSSI.intValue))
        }
        delegate.bleDevicesUpdate()
    }
}
