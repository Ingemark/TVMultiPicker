//
//  GenericMultiPickerViewController.swift
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
import SnapKit

public struct PickerDefinition {
    
    let data: [String]
    let cellWidth: CGFloat?
    let initialValueIndex: Int
    let remembersLastFocusedElement: Bool

    
    /// Defines single horizontal picker.
    ///
    /// - Parameters:
    ///   - data: Array of strings to be displayed in picker.
    ///   - cellWidth: Fixed picker cell width or nil for auto-calculation.
    ///   - initialValueIndex: Index of initially focused cell.
    ///   - remembersLastFocusedElement: Remembers focused element when picker regains focus.
    public init(
        data: [String],
        cellWidth: CGFloat?,
        initialValueIndex: Int,
        remembersLastFocusedElement: Bool) {
        
        self.data = data
        self.cellWidth = cellWidth
        self.initialValueIndex = initialValueIndex
        self.remembersLastFocusedElement = remembersLastFocusedElement
    }
}

open class MultiPickerViewController<PickedValueType>: UIViewController {
    
    public typealias ProcessDataAction = ([(index: Int, value: String)]) -> PickedValueType?
    public typealias ValuePickedAction = (PickedValueType?, UIViewController) -> ()
    
    public var pickers: [HorizontalStringCollectionView] = []
    
    var processDataAction: ProcessDataAction?
    var valuePickedAction: ValuePickedAction?

    var button: UIButton?
    
    var initialPickerIndex: Int = 0
    var configuration = MultiPickerConfiguration.defaultConfig

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addPickers()
        createAndAddButton()
        addFocusGuide()
        setInitialState()
    }
    
    
    /// Initializes and configures new multi-picker.
    ///
    /// - Parameters:
    ///   - pickers: Array of picker definitions.
    ///   - initialPickerIndex: Index of initially focused picker.
    ///   - configuration: UI configuration (can be omitted in which case default red-black config is used).
    ///   - processDataAction: Picked value processing function.
    ///   - valuePickedAction: Picked value handler.
    public init(_ pickers: [PickerDefinition],
         initialPickerIndex: Int = 0,
         configuration: MultiPickerConfiguration = MultiPickerConfiguration.defaultConfig,
         processDataAction: @escaping ProcessDataAction,
         valuePickedAction: @escaping ValuePickedAction) {
        super.init(nibName: nil, bundle: nil)
        
        self.processDataAction = processDataAction
        self.valuePickedAction = valuePickedAction
        self.configuration = configuration
        self.initialPickerIndex = initialPickerIndex

        self.pickers = pickers.map {
            HorizontalStringCollectionView(model: $0, configuration: configuration)
        }
    }
    
    init() {
        fatalError("init() has not been implemented")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// Returns currently focused (index,value) tuple.
    ///
    /// - Returns: Currently focused element in picker.
    public func getPickedValue() -> PickedValueType? {
        let data = pickers.map { ($0.focusedIndex, $0.focusedValue) }
        return processDataAction?(data)
    }
    
    func buttonTapepd() {
        guard
            let pickedValue = getPickedValue()
            else { return }
        valuePickedAction?(pickedValue, self)
    }
    
    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView is UIButton {
            for picker in pickers {
                picker.fade()
            }
        }
        if context.previouslyFocusedView is UIButton &&
            context.nextFocusedView is HorizontalStringCollectionView {
            pickers.last?.focus()
        }
    }

}


// MARK: - UI Configuration

extension MultiPickerViewController {
    
    fileprivate func configureUI() {
        view.backgroundColor = configuration.backgroundColor
    }
    
    fileprivate func addPickers() {
        var offset = configuration.topOffset
        for picker in pickers {
            view.addSubview(picker)
            picker.snp.makeConstraints { maker in
                maker.top.equalToSuperview().offset(offset)
                maker.width.equalTo(configuration.pickerWidth)
                maker.height.equalTo(configuration.pickerHeight)
                maker.centerX.equalToSuperview()
            }
            offset += (configuration.pickerHeight + configuration.offsetBetweenPickers)
        }
    }
    
    fileprivate func createAndAddButton() {
        let button = UIButton(type: .system)
        button.setTitle(configuration.doneButtonText, for: .normal)
        
        view.addSubview(button)
        button.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.bottom.equalToSuperview().offset(-configuration.doneButtonBottomOffset)
        }
        button.addTarget(self, action: #selector(buttonTapepd), for: .primaryActionTriggered)
        self.button = button
    }
    
    fileprivate func addFocusGuide() {
        let fg = UIFocusGuide()
        view.addLayoutGuide(fg)
        fg.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        fg.heightAnchor.constraint(equalToConstant: 20).isActive = true
        fg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        fg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fg.preferredFocusedView = button
    }
    
    fileprivate func setInitialState() {
        pickers.forEach { $0.updateFocus() }
        pickers.forEach { $0.fade() }
        pickers[initialPickerIndex].updateFocus()
    }

}
