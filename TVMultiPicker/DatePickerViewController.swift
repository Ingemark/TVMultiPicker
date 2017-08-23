//
//  DPickerViewController.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 02/08/2017.
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

import UIKit

public class DatePickerViewController: MultiPickerViewController<Date> {

    var yearPicker:     HorizontalStringCollectionView?
    var monthPicker:    HorizontalStringCollectionView?
    var dayPicker:      HorizontalStringCollectionView?
    
    /// Initializes and configures new date picker view.
    ///
    /// - Parameters:
    ///   - startYear: Lower year bound.
    ///   - initialYear: Initially focused year.
    ///   - configuration: UI configuration (default red/black if omitted).
    ///   - valuePickedAction: Handler for picked value.
    public init(
        startYear: Int,
        initialYear: Int,
        configuration: MultiPickerConfiguration = MultiPickerConfiguration.defaultConfig,
        valuePickedAction: @escaping ValuePickedAction) {
        super.init(
            [
                DatePickerUtilities.getYearPicker(startYear: startYear, initialYear: initialYear),
                DatePickerUtilities.getMonthPicker(),
                DatePickerUtilities.getDayPicker()
            ],
            configuration: configuration,
            processDataAction: { DatePickerUtilities.getDateFromComponents(components: $0.map { $0.1 })},
            valuePickedAction: valuePickedAction
        )
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setUpPickers()
        setUpPickerFocusActions()
    }
    
    private func setUpPickers() {
        yearPicker  = pickers[0]
        monthPicker = pickers[1]
        dayPicker   = pickers[2]
    }
    
    private func setUpPickerFocusActions() {
        yearPicker?.addOnFocusAction { _ in
            self.updateDatePickerValues()
        }
        monthPicker?.addOnFocusAction { _ in
            self.updateDatePickerValues()
        }
    }
    
    private func updateDatePickerValues() {
        guard
            let date = getPickedValue()
        else { return }
        
        let newDays = DatePickerUtilities.getDaysForYearMonth(for: date)
        dayPicker?.updateDataSource(with: newDays)
    }

}
