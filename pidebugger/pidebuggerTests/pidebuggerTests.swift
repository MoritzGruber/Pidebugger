//
//  pidebuggerTests.swift
//  pidebuggerTests
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import XCTest
@testable import pidebugger

class pidebuggerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTriStateButtonTap() {
        //define a new active button and check if the state and pi value change correctly
        let pi = raspberrypi.init(ip: "localhost")
        for index in 1...40 {
            let button = TriStateButton(frame: CGRect(x:10, y: (Int(10)), width: Int(10)-2, height: Int(10)-2), indexTag: (index), piObject: pi)

            if(pi.inactivePins.contains(index)){
                //here we make sure all deactivated buttons have no targets
                XCTAssertTrue(button.allTargets.count == 0)
            } else {
                //here we check if the buttun state, aswell as th pi.pins array change correctly
                button.nextState(button)
                XCTAssertTrue(button.buttonState == "h")
                XCTAssertTrue(pi.pins[index-1] == "h")
                button.nextState(button)
                XCTAssertTrue(button.buttonState == "i")
                XCTAssertTrue(pi.pins[index-1] == "i")
                button.nextState(button)
                XCTAssertTrue(button.buttonState == "l")
                XCTAssertTrue(pi.pins[index-1] == "l")

            }
           

        }
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
