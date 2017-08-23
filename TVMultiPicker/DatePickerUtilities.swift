//
//  DatePickerUtilities.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 31/07/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

struct DatePickerUtilities { private init() { }
    
    static func getDateFromComponents(components: [String]) -> Date? {
        let year    = components[0]
        let month   = components[1]
        let day     = components[2]
        let dateString = day + " " + month + " " + year
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d M yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard
            let date = dateFormatter.date(from: dateString)
        else {
            print("Could not convert components: \(components) to Date!")
            return nil
        }
        
        return date
    }
    
    
    static func getDaysForYearMonth(for date: Date) -> [String] {
        guard
            let daysRange = Calendar.current.range(of: .day, in: .month, for: date)
        else { return [] }
        let daysArray = Array(daysRange.lowerBound ..< daysRange.upperBound).map { "\($0)" }
        return daysArray
    }
    
    static func getYearPicker(startYear: Int, initialYear: Int) -> PickerDefinition {
        let currentYear = Calendar.current.component(.year, from: Date())
        let data = (startYear ... currentYear).map { "\($0)" }
        let definition = PickerDefinition(
            data: data,
            cellWidth: 150,
            initialValueIndex: initialYear - startYear,
            remembersLastFocusedElement: true
        )
        return definition
    }
    
    static func getMonthPicker() -> PickerDefinition {
        let data = [
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec"
        ]
        let definition = PickerDefinition(
            data: data,
            cellWidth: 100,
            initialValueIndex: 0,
            remembersLastFocusedElement: true
        )
        return definition
    }
    
    static func getDayPicker() -> PickerDefinition {
        let data = (1...30).map { "\($0)" }
        let definition = PickerDefinition(
            data: data,
            cellWidth: 100,
            initialValueIndex: 0,
            remembersLastFocusedElement: false
        )
        return definition
    }
    
}
