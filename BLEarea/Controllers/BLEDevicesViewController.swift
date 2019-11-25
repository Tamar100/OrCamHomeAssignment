//
//  ViewController.swift
//  BLEarea
//
//  Created by Tamar on 25/11/2019.
//  Copyright © 2019 Levi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BLEDevicesViewController: UIViewController {
    
    // MARK: - IBOutlet properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var swichScanStatus: UISwitch!
   
    // MARK: - IBAction properties
    @IBAction func swichValueChanged(_ sender: UISwitch) {
        if sender.isOn{
            BLEManager.sharedInstance.centralManagerScan()
        }else{
            BLEManager.sharedInstance.entralManagerStopScan()
            bleDevices.accept(BLEManager.sharedInstance.bleDevices)
        }
    }
    
    private let disposeBag = DisposeBag()
    private let bleDevices: BehaviorRelay<[Device]> = BehaviorRelay(value: [])
    
    var d = [Device]()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "BLE Scanner"
        
        BLEManager.sharedInstance.setup()
        BLEManager.sharedInstance.delegate = self
        
        bleDevices.bind(to: tableView.rx.items(cellIdentifier: CellIdentifier.BLEDeviceTableViewCell.rawValue, cellType: BLEDeviceTableViewCell.self)) { row, model, cell  in
            cell.bleDevice = model
        }.disposed(by: disposeBag)
    }
}

extension BLEDevicesViewController: UpdateBLEDevicesDelegate{
    func bleDevicesUpdate() {
        bleDevices.accept(BLEManager.sharedInstance.bleDevices)
    }
    
    
}

