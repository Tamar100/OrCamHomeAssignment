//
//  Device.swift
//  BLEarea
//
//  Created by Tamar on 25/11/2019.
//  Copyright © 2019 Levi. All rights reserved.
//

import UIKit

struct Device {

    var name:String?
    var uuid:String?
    var state:String?
    var rssi:Int?
    
    init (_name:String?, _uuid:String?, _state:String?, _rssi:Int?){
        name = _name
        uuid = _uuid
        state = _state
        rssi = _rssi
    }
}
