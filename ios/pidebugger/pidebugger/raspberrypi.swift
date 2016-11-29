//
//  raspberrrypi.swift
//  pidebugger
//
//  Created by Moritz Gruber on 18/10/16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation
//this vars are shared with all parts of the app
//used for ssh and socket connection
var piIp: String = "localhost"
var piUsername: String = "pi"
var piPassword:String = "raspberry"
/*
struct piCredentials {
    //ip
    var _ip: String = "localhost"
    var ip: String  {
        get{
            return _ip
        }
        set(newValue){
            _ip = newValue
        }
    }
    //username
    var _username: String = "pi"
    var username: String  {
        get{
            return _username
        }
        set(newValue){
            _username = newValue
        }
    }
    //password
    var _password:String = "raspberry";
    var password: String  {
        get{
            return _password
        }
        set(newValue){
            _password = newValue
        }
    }
}
 */

class raspberrypi {
    
    
    // Array initialized with 40 default values ("l" = low). Only 26 Pins of the Raspberry's GPIO are user-editable (3 possible states: "l" = low, "h" = high, "i" = input). 14 Pins are non user-editable (inactive) and will later be deactivated ("d" = deactivated).
    var pins = [String](repeating: "f", count: 40)
    

    
    // All inactive Pin numbers (1,2,4,6,9,14,17,20,25,27,28,30,34,39)
    let groundPins = [6,9,14,20,25,30,34,39];
    let I2CPins = [27,28];
    let V5Pins = [2,4];
    let V3Pins = [1,17];
    
    
    // Array with all inactive Pin numbers. They will be deactivated in the pinValue Array (with the value "d")
    let inactivePins:[Int];
    

    init(){
        //deactivate all inactive pins on init
        var currentPin = 0
        inactivePins = groundPins + I2CPins + V5Pins + V3Pins;
        
        for pinNumber in inactivePins {
            currentPin = pinNumber - 1
            pins[currentPin] = "d"
        }

    }
    
    
}
