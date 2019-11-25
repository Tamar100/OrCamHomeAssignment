//
//  BLEDeviceTableViewCell.swift
//  BLEarea
//
//  Created by Tamar on 25/11/2019.
//  Copyright © 2019 Levi. All rights reserved.
//

import UIKit

class BLEDeviceTableViewCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUUID: UILabel!
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var imageViewRssi: UIImageView!
    
    var bleDevice: Device! {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Set up
    func setup(){
        labelName.text = bleDevice.name != nil ? "Name: \(bleDevice.name!)" : nil
        labelUUID.text = bleDevice.uuid != nil ? "UUID: \(bleDevice.uuid!)" : nil
        labelState.text = bleDevice.state != nil ? "State: \(bleDevice.state!)" : nil
        guard let rssi = bleDevice.rssi else {
            return
        }
        switch (rssi) {                                                                                    // Display a signal strength indicator based on the RSSI
            case -84..<(-72): imageViewRssi.image = UIImage(named:"signalStrength-1")!
            case -72..<(-60): imageViewRssi.image = UIImage(named:"signalStrength-2")!
            case -60..<(-48): imageViewRssi.image = UIImage(named:"signalStrength-3")!
            case -48..<(127): imageViewRssi.image = UIImage(named:"signalStrength-4")!
            default: imageViewRssi.image = UIImage(named:"signalStrength-0")!
            }
    }

}
