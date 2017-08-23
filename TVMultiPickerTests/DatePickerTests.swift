//
//  DatePickerTests.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 18/08/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//

import XCTest
@testable import TVMultiPicker

class DatePickerTests: XCTestCase {

    func testSuccesfulDatePickerInitialization() {
        let datePicker = MultiPicker.datePicker { _ in }
        XCTAssertEqual(datePicker.pickers.count, 3)
    }
    
    func testDefaultDatePickerValue() {
        let datePicker = MultiPicker.datePicker(
            startYear: 1900,
            initialYear: 1991
        ) { _ in }
        
        var dateComponents = DateComponents()
        dateComponents.year = 1991
        dateComponents.month = 1
        dateComponents.day = 1
        
        guard
            let pickedDate = datePicker.getPickedValue(),
            let expectedDate = Calendar.current.date(from: dateComponents)
            else {
                XCTFail()
                return
        }
        
        XCTAssertEqual(
            Calendar.current.compare(pickedDate, to: expectedDate, toGranularity: .day),
            .orderedSame
        )
    }
    
}
