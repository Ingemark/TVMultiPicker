//
//  MultiPickerConfiguration.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 01/08/2017.
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

public struct MultiPickerConfiguration {
    
    public static let defaultConfig = MultiPickerConfiguration(
        backgroundColor: .black,
        cellPadding: 20,
        pickerWidth: 1250,
        pickerHeight: 66,
        topOffset: 200,
        offsetBetweenPickers: 150,
        unfocusedPickerAlphaValue: 0.7,
        focusedPickerAlphaValue: 1.0,
        doneButtonText: "Done",
        doneButtonBottomOffset: 200,
        focusedTextColor: UIColor.mpRed,
        focusedBgColor: UIColor.clear,
        focusedFont: .systemFont(ofSize: 60),
        normalTextColor: UIColor.mpLightGrey,
        normalBgColor: UIColor.clear,
        normalFont: .systemFont(ofSize: 40)
    )
    
    public static let singlePickerConfig = MultiPickerConfiguration(
        backgroundColor: .black,
        cellPadding: 20,
        pickerWidth: 1250,
        pickerHeight: 66,
        topOffset: 400,
        offsetBetweenPickers: 200,
        unfocusedPickerAlphaValue: 0.7,
        focusedPickerAlphaValue: 1.0,
        doneButtonText: "Done",
        doneButtonBottomOffset: 200,
        focusedTextColor: UIColor.mpRed,
        focusedBgColor: UIColor.clear,
        focusedFont: .systemFont(ofSize: 60),
        normalTextColor: UIColor.mpLightGrey,
        normalBgColor: UIColor.clear,
        normalFont: .systemFont(ofSize: 40)
    )
    
    let backgroundColor: UIColor
    
    let cellPadding: CGFloat
    let pickerWidth: CGFloat
    let pickerHeight: CGFloat
    let topOffset: CGFloat
    let offsetBetweenPickers: CGFloat
    
    let unfocusedPickerAlphaValue: CGFloat
    let focusedPickerAlphaValue: CGFloat
    
    let doneButtonText: String
    let doneButtonBottomOffset: Int
    
    let focusedTextColor: UIColor
    let focusedBgColor: UIColor
    let focusedFont: UIFont
    
    let normalTextColor: UIColor
    let normalBgColor: UIColor
    let normalFont: UIFont
    
}
