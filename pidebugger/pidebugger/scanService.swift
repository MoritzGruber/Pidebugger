//
//  scanService.swift
//  pidebugger
//
//  Created by Moritz Gruber on 28/11/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation
import LANScanner

class scanService: LANScannerDelegate {

    init(){
        let scanner = LANScanner(delegate: self, continuous: false)
        scanner.startScan()
        
    }
    func LANScannerDiscovery(_ device: LANDevice){
        print("asdfa")
        print(device.hostName)
        print(device.ipAddress)

    }
    func LANScannerFinished(){
        print("asdfa2")
    }
    func LANScannerRestarted(){
        print("asdfa3")
    }
    func LANScannerFailed(_ error: NSError){
        print("asdfa4")
    }

}
