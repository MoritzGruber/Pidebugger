//
//  raspberrrypi.swift
//  pidebugger
//
//  Created by Moritz Gruber on 18/10/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation

class raspberrypi {
    var pins = [String](repeating: "f", count: 40)
    
    let inactivePins = [1,2,4,6,9,14,17,20,25,27,28,30,34,39]
    
    init(){
        
        var currentPin = 0
        
        for pinNumber in inactivePins {
            
            currentPin = pinNumber - 1
            pins[currentPin] = "d"
        }
    }
    
}
