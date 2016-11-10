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
        
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        if tag == 43 {
        layer.backgroundColor = UIColor.black.cgColor
            /*
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12.0
        
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        */
        }
        
        else if tag == 41 {
            layer.backgroundColor = UIColor.orange.cgColor
            /*
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12.0
        
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        */
        }
            
        else if tag == 42 {
            layer.backgroundColor = UIColor.red.cgColor
            /*
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12.0
        
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        */
        }
            
        else if tag == 44 {
            layer.backgroundColor = UIColor.gray.cgColor
            /*
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12.0
        
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        */
        }
    
        else {
            layer.backgroundColor = UIColor.green.cgColor
            /*
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12.0
        
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            */
 
        self.addTarget(self, action: #selector(TriStateButton.nextState(_:)), for: UIControlEvents.touchUpInside)
       
            
        }
        
        
    }
    
    
    func nextState(_ sender: TriStateButton) {
        
        currentPinState = (currentPinState + 1) % 3
        
        self.setTitle(pinState[currentPinState], for: UIControlState.normal)
    }
    

    
}
