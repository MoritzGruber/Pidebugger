//
//  raspberrrypi.swift
//  pidebugger
//
//  Created by Moritz Gruber on 18/10/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation

class raspberrypi {
    
    // Array initialized with 40 default values ("l" = low). Only 26 Pins of the Raspberry's GPIO are user-editable (3 possible states: "l" = low, "h" = high, "i" = input). 14 Pins are non user-editable (inactive) and will later be deactivated ("d" = deactivated).
    var pins = [String](repeating: "l", count: 40)
    
    
    // All inactive Pin numbers (1,2,4,6,9,14,17,20,25,27,28,30,34,39)
    let groundPins = [6,9,14,20,25,30,34,39];
    let I2CPins = [27,28];
    let V5Pins = [2,4];
    let V3Pins = [1,17];
    
    
    // Array with all inactive Pin numbers. They will be deactivated in the pinValue Array (with the value "d")
    let inactivePins:[Int];
    
    
    // Deactivate all inactive Pin numbers in the pins Array.
    init(){
        
        var currentPin = 0
        inactivePins = groundPins + I2CPins + V5Pins + V3Pins;
        
        for pinNumber in inactivePins {
            currentPin = pinNumber - 1
            pins[currentPin] = "d"
        }

    }
    
}
