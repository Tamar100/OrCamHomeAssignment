//
//  Extensions.swift
//  BLEarea
//
//  Created by Tamar on 25/11/2019.
//  Copyright © 2019 Levi. All rights reserved.
//

import UIKit
import CoreBluetooth

extension UIAlertController {
    func show() {
        let win = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        win.rootViewController = vc
        win.windowLevel = UIWindow.Level.alert + 1
        win.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
    
    func showAlertView(title:String="",msg:String="" ,okButtonTitle:String="OK",okFunction:@escaping ()->()={}){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title:okButtonTitle, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            okFunction()
        }
        alertController.addAction(okAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if #available(iOS 9.0, *) {
            alertController.preferredAction = okAction
        }
        alertController.show()
    }
}

extension CBPeripheralState {
    var stringRepresentation: String {
        switch self {
        case .disconnected: return "disconnected"
        case .connected: return "connected"
        case .connecting: return "connecting"
        case .disconnecting: return "disconnecting"
        default:
            return ""
        }
    }
}
