//
//  raspberrrypi.swift
//  pidebugger
//
//  Created by Moritz Gruber on 18/10/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation

class raspberrypi {
    var pins = [pin](repeating: pin.low, count: 40)
    
    enum pin {
        case low;
        case high;
        case input;
        
    }
    
    init(){
        for i in 0..<40 {
            pins[i] = pin.low
        }
    }
    
}
