//
//  scanService.swift
//  pidebugger
//
//  Created by Moritz Gruber on 28/11/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//


import UIKit
import Foundation


class scanService: NSObject, MMLANScannerDelegate  {
    var lanScanner : MMLANScanner!
    var VC: ViewControllerSetup
    
    init(VC: ViewControllerSetup) {
        self.VC = VC
        super.init()
        self.lanScanner = MMLANScanner(delegate:self)
        
        
    }
    
    func start() {
        //on start we start a wifi scan that gets killed by a async task after 20 sec if he finds nothing
        DispatchQueue.global(qos: .background).async {
            sleep(20)
            self.lanScanner.stop()
        }
       
        print("scan started:")
        self.lanScanner.start()

        
    }

    func lanScanDidFindNewDevice(_ device: Device!){
        //get the brand of the found divce
        if let brand = device.brand {
            print(brand)
            //detect if it is a raspberryPI
            if(device.brand.contains("aspberry")){
                if let ip = device.ipAddress{
                    print(ip)
                    //thaten save the ip and stop the scan
                    piIp = ip;
                    self.lanScanner.stop()
                    VC.gotIpAdress()
                }
                
            }
        } else {
            print("Unable to retrieve the brand")
        }
        
    }
    func lanScanDidFinishScanning(with status: MMLanScannerStatus){

    }
    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int){
        
    }
    func lanScanDidFailedToScan(){
      
    }
    
}
