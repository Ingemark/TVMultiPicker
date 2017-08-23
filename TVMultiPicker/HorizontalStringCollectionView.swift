//
//  HorizontalStringCollectionView.swift
//  TVMultiPicker
//
//  Created by Filip Dujmušić on 25/07/2017.
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

public class HorizontalStringCollectionView: UICollectionView {
    
    public typealias OnFocusAction = (Int) -> ()
    
    public var focusedValue: String {
        return data[focusedIndex]
    }
    
    public var focusedIndex: Int = 0
    
    fileprivate var onFocusAction: OnFocusAction?
    
    fileprivate var data: [String] = []
    
    fileprivate var cellWidth: CGFloat?
    
    var configuration: MultiPickerConfiguration = MultiPickerConfiguration.defaultConfig
    
    convenience init(model: PickerDefinition, configuration: MultiPickerConfiguration) {
        
        func createFlowLayout() -> UICollectionViewFlowLayout {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumInteritemSpacing = 0
            return flowLayout
        }
        
        func initializeProperties() {
            self.configuration = configuration
            self.focusedIndex = model.initialValueIndex
            self.data = model.data
            self.cellWidth = model.cellWidth
            delegate = self
            dataSource = self
        }
        
        func configureUI() {
            remembersLastFocusedIndexPath = model.remembersLastFocusedElement
            isScrollEnabled = false
            contentMode = .center
            fade()
            register(
                HorizontalStringCollectionViewCell.classForCoder(),
                forCellWithReuseIdentifier: HorizontalStringCollectionViewCell.identifier
            )
        }
        
        self.init(frame: CGRect.zero, collectionViewLayout: createFlowLayout())
        
        initializeProperties()
        configureUI()
        
    }

    
    public func updateFocus() {
        clearAllCells()
        reloadData()
        scrollToItem(
            at: IndexPath(row: focusedIndex, section: 0),
            at: .centeredHorizontally,
            animated: true)
        
        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                        with coordinator: UIFocusAnimationCoordinator) {
        guard
            let indexPath = context.nextFocusedIndexPath
        else { return }
        
        focus()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func formatCell(_ cell: HorizontalStringCollectionViewCell, focused: Bool) {
        cell.textLabel.font =
            focused ?
                configuration.focusedFont : configuration.normalFont
        cell.textLabel.textColor =
            focused ?
                configuration.focusedTextColor : configuration.normalTextColor
        cell.backgroundColor =
            focused ?
                configuration.focusedBgColor : configuration.normalBgColor
    }

    func clearAllCells() {
        let horizontalCells = visibleCells.map { $0 as? HorizontalStringCollectionViewCell }.flatMap { $0 }
        horizontalCells.forEach {
            formatCell($0, focused: false)
            $0.setNeedsDisplay()
        }
    }
    
    
    /// Updates picker's data source with newly given values.
    ///
    /// - Parameter data: New values to be displayed in picker.
    public func updateDataSource(with data: [String]) {
        self.data = data
        self.focusedIndex = 0
        
        reloadData()
        scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func fade() {
        alpha = configuration.unfocusedPickerAlphaValue
    }
    
    func focus() {
        alpha = configuration.focusedPickerAlphaValue
    }
    
    
    /// Sets up action for handling focus changes in picker.
    ///
    /// - Parameter action: Action to be triggered when focus change occurs within picker.
    public func addOnFocusAction(_ action: @escaping OnFocusAction) {
        onFocusAction = action
    }
    
}

extension HorizontalStringCollectionView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = HorizontalStringCollectionViewCell.identifier
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
                ) as? HorizontalStringCollectionViewCell
            else {
                fatalError("Could not deque cell with identifier " + cellIdentifier)
        }
        
        cell.accessibilityIdentifier = "\(indexPath.row)"
        cell.textLabel.text = data[indexPath.row]
        cell.onFocusAction = { index in
            self.focusedIndex = index
            self.onFocusAction?(index)
        }
        cell.parentCollectionView = self
        
        let focused = (indexPath.row == focusedIndex)
        formatCell(cell, focused: focused)
        cell.setNeedsDisplay()
        
        return cell
    }
}

extension HorizontalStringCollectionView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let cellIdentifier = HorizontalStringCollectionViewCell.identifier
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath) as? HorizontalStringCollectionViewCell
            else {
                fatalError("Could not deque cell with identifier " + cellIdentifier)
        }
        
        let focused = (indexPath.row == focusedIndex)
        formatCell(cell, focused: focused)
        cell.setNeedsDisplay()
    }
    
    
    public func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: focusedIndex, section: 0)
    }
    
}

extension HorizontalStringCollectionView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth: CGFloat
        
        if let cellWidth = cellWidth {
            totalCellWidth = cellWidth * CGFloat(data.count)
        } else {
            totalCellWidth =
                HorizontalStringCollectionUtilities.calculateCellsWidth(
                    forArray: data,
                    configuration: configuration
                )
        }
        
        if totalCellWidth > configuration.pickerWidth {
            return .zero
        }
        
        let leftInset = (configuration.pickerWidth - totalCellWidth) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let calculatedWidth = HorizontalStringCollectionUtilities.calculateCellWidth(
            forText: data[indexPath.row],
            configuration: configuration,
            focused: indexPath.row == focusedIndex
        )
        return CGSize(width: cellWidth ?? calculatedWidth, height: bounds.height)
    }
    
}

