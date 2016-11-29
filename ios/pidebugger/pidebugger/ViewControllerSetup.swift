//
//  ViewControllerSetup.swift
//  pidebugger
//
//  Created by Moritz Gruber on 29/11/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit


//View controller for the setup screen
class ViewControllerSetup: UIViewController  {
    
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
       //we start scanning the wifi network
       let wifiScanner = scanService.init(VC: self)
       wifiScanner.start()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let label = statusLabel {
            label.text = "Status: Searching for to Pi"
        }
        
    }
    
    func gotIpAdress() {
        //wifiScanner calls this if he is finished
        
        
        if let label = statusLabel {
            label.text = "Status: Connecting to Pi"
            }
        
        //sshService.start(VC: self)

    }
    
    func setLoadingPercentage(percentage: Float, status: String){
        
        statusLabel.text = "Status: \(status)"
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
