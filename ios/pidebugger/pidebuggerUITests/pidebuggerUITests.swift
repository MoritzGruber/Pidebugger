//
//  pidebuggerUITests.swift
//  pidebuggerUITests
//
//  Created by Moritz Gruber on 17/10/2016.
//  Copyright © 2016 Moritz Gruber. All rights reserved.
//

import XCTest

class pidebuggerUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllButtonsTap() {
        
        //define diffrent states of the button
        
        let states:[String] = ["h","i", "l"]
        
        //get all UIButton elements

        
        let activePinsLLowHHighIInputElementsQuery = XCUIApplication().otherElements.containing(.staticText, identifier:"Active Pins (l = low, h = high, i = input)")
        
        //check if all th
        
        var foundMatchingButtons = XCUIApplication().otherElements.containing(.image, identifier:"raspi_background").children(matching: .button).matching(identifier: states[2])
        
        XCTAssertEqual(foundMatchingButtons.count, 26, "found instead: \(foundMatchingButtons.debugDescription)")
        
        
        
        //we test all 3 states each button can have
        for stateIndex in 0...2 {
            //we go over all buttons and tap them once for each state
            for buttonIndex in 1...44 {
                //find by index and tap that button
                let button = activePinsLLowHHighIInputElementsQuery.children(matching: .button).allElementsBoundByIndex[buttonIndex]
                button.tap()
                
            }

            // now we check if all buttons that are activated (26 buttons) have changed to the next state
            foundMatchingButtons = XCUIApplication().otherElements.containing(.image, identifier:"raspi_background").children(matching: .button).matching(identifier: states[stateIndex])
            XCTAssertEqual(foundMatchingButtons.count, 26, "found instead: \(foundMatchingButtons.debugDescription)")

        }
        
    }
    
}
