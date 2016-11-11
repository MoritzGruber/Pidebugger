//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pi = raspberrypi.init()
        print("              PI:  \( pi.pins[1])");
        
        socketService.connect();
 
        sshService.start();
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Array initialized with 40 default values ("f" = false, "t" = true, "i" = input)
    var pinValue = [String](repeating: "f", count: 40)
    
    

}

