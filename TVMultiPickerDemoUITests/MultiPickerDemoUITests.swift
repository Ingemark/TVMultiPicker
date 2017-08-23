//
//  MultiPickerDemoUITests.swift
//  TVMultiPickerDemoUITests
//
//  Created by Filip Dujmušić on 21/08/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//

import XCTest

class MultiPickerDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testBasicDatePick() {
        
        XCUIRemote.shared().press(.select)
        sleep(1)
        XCUIRemote.shared().press(.right)
        sleep(1)
        XCUIRemote.shared().press(.down)
        sleep(1)
        XCUIRemote.shared().press(.right)
        sleep(1)
        XCUIRemote.shared().press(.down)
        sleep(1)
        XCUIRemote.shared().press(.right)
        sleep(1)
        XCUIRemote.shared().press(.down)
        sleep(1)
        XCUIRemote.shared().press(.select)
        sleep(2)
        
        XCTAssertTrue(XCUIApplication().buttons["Feb 3, 1991"].exists)
    }
    
}
