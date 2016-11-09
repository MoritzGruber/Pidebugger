//
//  TriStateButton.swift
//  pidebugger
//
//  Created by Monty Rock on 08.11.16.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import Foundation

class TriStateButton: UIButton {
    
    let pinState: [String] = ["f", "t", "i"]
    
    var currentPinState = 0
    
    required init(coder aCoder: NSCoder) {
        super.init(coder: aCoder)!
        
        self.addTarget(self, action: #selector(TriStateButton.nextState(_:)), for: UIControlEvents.touchUpInside)
        
    }
    
    func nextState(_ sender: TriStateButton) {
        
        currentPinState = (currentPinState + 1) % 3
        
        self.setTitle(pinState[currentPinState], for: UIControlState.normal)
    }
    

    
}
