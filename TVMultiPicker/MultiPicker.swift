//
//  MultiPicker.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 03/08/2017.
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
import UIKit

public struct MultiPicker { private init() { }

    
    /// Creates configured date picker ready to be
    /// presented.
    ///
    /// - Parameters:
    ///   - startYear: Lower year bound.
    ///   - initialYear: Initially focused year.
    ///   - configuration: UI configuration (default red/black if omitted).
    ///   - valuePickedAction: Handler for picked value.
    /// - Returns: Returns configured DatePickerViewController.
    public static func datePicker(
        startYear: Int = 1900,
        initialYear: Int = 1990,
        configuration: MultiPickerConfiguration = .defaultConfig,
        valuePickedAction: @escaping (Date?, UIViewController) -> ()
    ) -> DatePickerViewController {
    
        let vc = DatePickerViewController(
            startYear: startYear,
            initialYear: initialYear,
            configuration: configuration,
            valuePickedAction: valuePickedAction
        )
        
        return vc
    }

}
