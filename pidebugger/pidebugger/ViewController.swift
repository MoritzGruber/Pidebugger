//
//  ViewController.swift
//  pidebugger
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var right: UIStackView!
    @IBOutlet weak var left: UIStackView!
    let pi = raspberrypi.init()
    //print("              PI:  \( pi.pins[1])");
    
    
    //2 variables to temporary store data from the TriStateButton class before adding it to the pinValue Array
    var buttonTag: Int!
    var buttonState: String!
    var screenwidth : CGFloat!
    var screenheight : CGFloat!
    
    //Array initialized with 40 default values ("f" = false). Only 26 Pins of the GPIO are user-editable (3 states "f" = false, "t" = true, "i" = input). 14 Pins are non user-editable and will be deactivated ("d" = deactivated).
    var pinValue = [String](repeating: "f", count: 40)

    
    
    var currentPin = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenwidth = self.view.frame.size.width
        screenheight = self.view.frame.size.height
        print("\(screenwidth) ,\(screenheight)")
        //socketService.connect();
 
        //sshService.start();
        
        
        //Loop for deactivating all inactive Pins
        
        let screenWidthInPixels = UIScreen.main.nativeBounds.width;
        let screenHeightInPixels = UIScreen.main.nativeBounds.height;
        print(screenWidthInPixels);
        print(screenHeightInPixels);
        
        
        
        let spacingTop = 30;
        let spacingBot = 50;
        let oneButtonSpace = (Int(screenheight!) - (spacingTop + spacingBot))/20;
                print(oneButtonSpace);
        var yHeight = spacingTop;
        let xFirstRow = (Int(screenwidth) - 4 * oneButtonSpace);
        let xSecRow = (Int(screenwidth) - 2 * oneButtonSpace);
        print(xFirstRow);
        print(xSecRow);
        // Do any additional setup after loading the view, typically from a nib.
        super.viewDidLoad()
        for index in 1...20 {
            let button = TriStateButton(frame: CGRect(x: xFirstRow, y: (Int(yHeight)), width: Int(oneButtonSpace)-2, height: Int(oneButtonSpace)-2), indexTag:(index * 2 ) - 1, piObject: pi);
            //button.setTitle("x", for: .normal);
            //button.backgroundColor = UIColor.blue;
            //self.view.addSubview(button)
            
                print(yHeight);
                self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
            
        }
        yHeight = spacingTop;
        for index in 1...20 {
            
            let button = TriStateButton(frame: CGRect(x:xSecRow, y: (Int(yHeight)), width: Int(oneButtonSpace)-2, height: Int(oneButtonSpace)-2), indexTag: (index * 2), piObject: pi);
            //button.setTitle("y", for: .normal);
            //button.backgroundColor = UIColor.blue;
            //self.view.addSubview(button)
            
            print(yHeight);
            self.view.addSubview(button);
            yHeight += Int(oneButtonSpace);
            
        }

    }
    
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //Storing the current Pin state of a Button in the pinValue Array (Button tag - 1 = corresponding index in the Array)
    @IBAction func getButtonTag(_ sender: TriStateButton) {
    
        buttonTag = (sender.indexTag)
        buttonState = sender.pinState[sender.currentPinState]
        
        pi.pins[buttonTag] = buttonState
        
        setPinValues()
    }
    
    
    //Test function to see if pinValue Array values are set properly
    func setPinValues(){
        
        print(buttonTag)
        print(buttonState)
        print(pi.pins)
    }
 
}

