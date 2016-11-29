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
    
    @IBOutlet weak var setup: UIButton!
    @IBOutlet weak var skip: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!

    override func viewDidLoad() {
       //we start scanning the wifi network
        
        
    }

    @IBAction func skipaction(_ sender: Any) {
        let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "main")
        self.show(vc as! UIViewController, sender: vc)

    }
    @IBAction func setupaction(_ sender: Any) {
         sshService.start(VC: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        let wifiScanner = scanService.init(VC: self)
        wifiScanner.start()
        if let label = statusLabel {
            label.text = "Status: Searching for to Pi"
        }
        if let bar = progress {
            bar.setProgress(0.0, animated: false)
        }
        

        
    }
    
    func gotIpAdress() {
        //wifiScanner calls this if he is finished
        
        
        if let label = statusLabel {
            label.text = "Status: Ready, Pi found"
            }
        if let bar = progress {
            bar.setProgress(0.1, animated: true)
        }
        
        
        
        

    }
    
    func setLoadingPercentage(percentage: Float, status: String){
        
        
        
        if let label = statusLabel {
            label.text = "Status: \(status)"
        }
        if let bar = progress {
            bar.setProgress(percentage, animated: true)
        }
        if(status == "Done"){
            let vc : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "main")
            self.show(vc as! UIViewController, sender: vc)
        }

        
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
