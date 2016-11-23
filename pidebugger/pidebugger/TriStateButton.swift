//
//  TriStateButton.swift
//  pidebugger
//
//  Created by Monty Rock on 08.11.16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation

class TriStateButton: UIButton {
    
    //3 active Pin states: "f" = false, "t" = true, "i" = input
    let pinState: [String] = ["l", "h", "i"]
    var indexTag:Int = 0
    
    //initialize Pin state with index 0 (= "f")
    var currentPinState = 0
    var buttonTag: Int!
    var buttonState: String!
    var pi:raspberrypi!
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    required convenience init(frame: CGRect, indexTag: Int, piObject: raspberrypi) {
        // set myValue before super.init is called
        
        self.init(frame: frame);
        self.pi = piObject;
        self.indexTag = indexTag;
        
        
        // set other operations after super.init, if required
        backgroundColor = UIColor.red
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor

        layer.cornerRadius = (frame.width / 2)
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        self.setTitleColor(UIColor.clear, for: UIControlState.normal)
        //self.setTitle("f", for: UIControlState.normal)
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        //tag 43 is used for all non-active buttons (no user-editable Pins) with "ground"-function (black buttons).
        if pi.groundPins.contains(indexTag) {
            print("make black")
            layer.backgroundColor = UIColor.black.cgColor
        }
            
            //tag 41 is used for all non-active buttons (no user-editable Pins) with "+3,3V"-function (orange buttons).
        else if pi.V3Pins.contains(indexTag) {
            
            layer.backgroundColor = UIColor.orange.cgColor
        }
            
            //tag 42 is used for all non-active buttons (no user-editable Pins) with "+5V"-function (red buttons).
        else if pi.V5Pins.contains(indexTag) {
            
            layer.backgroundColor = UIColor.red.cgColor
        }
            
            //tag 44 is used for all non-active buttons (no user-editable Pins) with "ID"-function (gray buttons).
        else if pi.I2CPins.contains(indexTag) {
            
            layer.backgroundColor = UIColor.gray.cgColor
        }
            
            //all other buttons are active buttons (in total 26 user-editable Pins) with one of three states "f", "t" or "i" (green buttons). These states will be stored in the pinValue Array in the ViewController class.
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
    
    //cylce-function on button-click through the three active Pin states ("f", "t", "i")
    func nextState(_ sender: TriStateButton) {
        
        print(indexTag);
        currentPinState = (currentPinState + 1) % 3
        
        self.setTitle(pinState[currentPinState], for: UIControlState.normal)
      
            
            buttonTag = (sender.indexTag - 1)
            buttonState = sender.pinState[sender.currentPinState]
            
            pi.pins[buttonTag] = buttonState
            func setPinValues(){
            
            print(buttonTag)
            print(buttonState)
            print(pi.pins)
            
            }
            setPinValues()
    }
    
        
        //Test function to see if pinValue Array values are set properly
        
    
}
