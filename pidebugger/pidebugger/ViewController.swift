//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    let pi = raspberrypi.init()
    //print("              PI:  \( pi.pins[1])");
    
    
    //2 variables to temporary store data from the TriStateButton class before adding it to the pinValue Array
    var buttonTag: Int!
    var buttonState: String!
    
    
    //Array initialized with 40 default values ("f" = false). Only 26 Pins of the GPIO are user-editable (3 states "f" = false, "t" = true, "i" = input). 14 Pins are non user-editable and will be deactivated ("d" = deactivated).
    var pinValue = [String](repeating: "f", count: 40)

    //Array with all inactive Pin numbers. They will be deactivated in the pinValue Array
    let inactivePins = [1,2,4,6,9,14,17,20,25,27,28,30,34,39]

    
    var currentPin = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        socketService.connect();
 
        sshService.start();
        
        
        //Loop for deactivating all inactive Pins
        for pin in inactivePins {
            
            currentPin = pin - 1
            pinValue[currentPin] = "d"
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //Storing the current Pin state of a Button in the pinValue Array (Button tag - 1 = corresponding index in the Array)
    @IBAction func getButtonTag(_ sender: TriStateButton) {
    
        buttonTag = (sender.tag - 1)
        buttonState = sender.pinState[sender.currentPinState]
        
        pi.pins[buttonTag] = buttonState
        
        setPinValues()
    }
    
    
    //Test function to see if pinValue Array values are set properly
    func setPinValues(){
        
        print(buttonTag)
        print(buttonState)
        print(pinValue)
    }
 
}

