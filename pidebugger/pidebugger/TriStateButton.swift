//
//  TriStateButton.swift
//  pidebugger
//
//  Created by Monty Rock on 08.11.16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation

class TriStateButton: UIButton {
    
    // 3 possible active Pin states: "l" = low, "h" = high, "i" = input
    let pinState: [String] = ["l", "h", "i"]
    
    // Initialize the Pin state with index 0 for the first value in the pinState Array (0 = "l")
    var currentPinState = 0
    
    // Variable to store a buttons index in the pins Array from the raspberrypi class
    var indexTag:Int = 0
    
    // Variable to store a buttons number (= Pin number of the Raspberry's GPIO)
    var buttonTag: Int!
    
    // Variable to store the value of the pinState Array
    var buttonState: String!
    
    var pi:raspberrypi!
    
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    
    // Setting shape and look of the buttons
    required convenience init(frame: CGRect, buttonTag: Int, piObject: raspberrypi) {
        
        // Set myValue before super.init is called
        self.init(frame: frame);
        self.pi = piObject;
        self.buttonTag = buttonTag;
        
        // Set other operations after super.init, if required
        backgroundColor = UIColor.red
        
        // General shape and look of the buttons
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = (frame.width / 2)
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.setTitleColor(UIColor.clear, for: UIControlState.normal)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        
        
        // All non-active buttons (no user-editable Pins of the GPIO) with "ground"-function (black buttons).
        if pi.groundPins.contains(buttonTag) {
            layer.backgroundColor = UIColor.black.cgColor
        }
            
        // All non-active buttons (no user-editable Pins of the GPIO) with "+3,3V"-function (orange buttons).
        else if pi.V3Pins.contains(buttonTag) {
            layer.backgroundColor = UIColor.orange.cgColor
        }
            
        // All non-active buttons (no user-editable Pins of the GPIO) with "+5V"-function (red buttons).
        else if pi.V5Pins.contains(buttonTag) {
            layer.backgroundColor = UIColor.red.cgColor
        }
            
        // All non-active buttons (no user-editable Pins of the GPIO) with "ID"-function (gray buttons).
        else if pi.I2CPins.contains(buttonTag) {
            layer.backgroundColor = UIColor.gray.cgColor
        }
            
        // Helper for shaping the buttons of the description legend. Each correct color will be set in the ViewController class because of their own value range.
        else if buttonTag == 0 {
            layer.backgroundColor = UIColor.clear.cgColor
        }
            
        // All other buttons are active buttons (in total 26 user-editable Pins for the Raspberry's GPIO) with one of the possbile 3 states "l", "h" or "i" (green buttons). The states will be stored in the pinValue Array in the ViewController class.
        else {
            layer.backgroundColor = UIColor.green.cgColor
            self.setTitle(pinState[currentPinState], for: UIControlState.normal)
            self.addTarget(self, action: #selector(TriStateButton.nextState(_:)), for: UIControlEvents.touchUpInside)
            self.setTitleColor(UIColor.black, for: UIControlState.normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Cylce-function on button-click through the three active Pin states ("l", "h", "i"). The current Pin state value will be stored on the fly in the pins Array.
    func nextState(_ sender: TriStateButton) {
        
        // Cycle through the 3 possible index numbers for the pinState Array (0,1,2)
        currentPinState = (currentPinState + 1) % 3
        
        // Display the current value on a button
        self.setTitle(pinState[currentPinState], for: UIControlState.normal)
      
        // Store the index number for the pins Array (button number - 1 = index number).
        indexTag = (sender.buttonTag - 1)
        
        // Store the current Pin state in the buttonState variable.
        buttonState = sender.pinState[sender.currentPinState]
        
        // Set the current Pin state value on the related position in the pins Array.
        pi.pins[indexTag] = buttonState
        
        
            // Check if the values are set properly in the Array
            func setPinValues(){
            
            print(indexTag)
            print(buttonTag)
            print(buttonState)
            print(pi.pins)
            }
            setPinValues()
        
    }
    
    
        
    
}
