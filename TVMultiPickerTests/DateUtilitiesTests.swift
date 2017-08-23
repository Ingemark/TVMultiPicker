//
//  DateUtilitiesTest.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 18/08/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//

import XCTest
@testable import TVMultiPicker

class DateUtilitiesTest: XCTestCase {

    func testDateFromComponents() {
        
        let components = ["1990", "May", "4"]
        
        var dateComponents = DateComponents()
        dateComponents.year = 1990
        dateComponents.month = 5
        dateComponents.day = 4
        
        guard
            let generatedDate = DatePickerUtilities.getDateFromComponents(components: components),
            let expectedDate = Calendar.current.date(from: dateComponents)
            else {
                XCTFail()
                return
        }
        
        XCTAssert(Calendar.current.compare(generatedDate, to: expectedDate, toGranularity: .day) == .orderedSame)
    }
    
    func testDaysForYearMonth() {
        
        var dateComponents = DateComponents()
        dateComponents.year = 1990
        dateComponents.month = 2
        dateComponents.day = 1
        guard
            let date = Calendar.current.date(from: dateComponents)
            else {
                XCTFail()
                return
        }
        let days = DatePickerUtilities.getDaysForYearMonth(for: date)
        let expectedDays = (1...28).map { "\($0)" }
        XCTAssertEqual(days, expectedDays)
        
    }
    
}
