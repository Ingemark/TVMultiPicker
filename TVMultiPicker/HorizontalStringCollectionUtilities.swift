//
//  HorizontalStringCollectionUtilities.swift
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
import UIKit

struct HorizontalStringCollectionUtilities { private init() { }
    
    static func calculateCellWidth(
        forText text: String,
        configuration: MultiPickerConfiguration,
        focused: Bool) -> CGFloat {
    
        let label = UILabel()
        label.text = text
        label.font = focused ? configuration.focusedFont : configuration.normalFont
        
        let textWidth = label.intrinsicContentSize.width
        
        return textWidth + 2 * configuration.cellPadding
    }
    
    static func calculateCellsWidth(
        forArray array: [String],
        configuration: MultiPickerConfiguration) -> CGFloat {
        
        return array
                .map {
                        calculateCellWidth(
                            forText: $0,
                            configuration: configuration,
                            focused: false
                        )
                     }
                .reduce(0, +)
    }
}
