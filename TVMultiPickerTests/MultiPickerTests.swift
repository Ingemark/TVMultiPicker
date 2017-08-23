//
//  MultiPickerTests.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 07/08/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//

import XCTest
@testable import TVMultiPicker

class MultiPickerTests: XCTestCase {

    func testSuccesfulMultiPickerInitialization() {
        let multiPicker = MultiPickerViewController<String>(
            [
                PickerDefinition(
                    data: ["Item 1", "Item 2"],
                    cellWidth: nil,
                    initialValueIndex: 0,
                    remembersLastFocusedElement: false
                )
            ], processDataAction: { data in
                return ""
            }, valuePickedAction: { value in
                
            }
        )
        XCTAssertEqual(multiPicker.pickers.count, 1)
    }
    
    func testSuccesfulMultiPickerInitializationWithConfiguration() {
        let config = MultiPickerConfiguration(
            backgroundColor: .yellow,
            cellPadding: 50,
            pickerWidth: 50,
            pickerHeight: 50,
            topOffset: 100,
            offsetBetweenPickers: 100,
            unfocusedPickerAlphaValue: 0.4,
            focusedPickerAlphaValue: 1.0,
            doneButtonText: "Done",
            doneButtonBottomOffset: 100,
            focusedTextColor: .blue,
            focusedBgColor: .yellow,
            focusedFont: .systemFont(ofSize: 40),
            normalTextColor: .black,
            normalBgColor: .white,
            normalFont: .systemFont(ofSize: 30)
        )
        _ = MultiPickerViewController<String>(
            [
                PickerDefinition(
                    data: ["Item 1", "Item 2"],
                    cellWidth: nil,
                    initialValueIndex: 0,
                    remembersLastFocusedElement: false
                )
            ],
            configuration: config,
            processDataAction: { data in
                return ""
            }, valuePickedAction: { value in
            
            }
        )
    }
    
    func testDefaultMultiPickerValues() {
        let multiPicker = MultiPickerViewController<String>(
            [
                PickerDefinition(
                    data: ["a", "b"],
                    cellWidth: nil,
                    initialValueIndex: 0,
                    remembersLastFocusedElement: false
                ),
                PickerDefinition(
                    data: ["a", "b"],
                    cellWidth: nil,
                    initialValueIndex: 1,
                    remembersLastFocusedElement: false
                )
            ], processDataAction: { data in
                return data[0].value + data[1].value
            }, valuePickedAction: { value in
                
            }
        )
        XCTAssertEqual(multiPicker.getPickedValue(), "ab")
    }
    
}
