//
//  HorizontalStringCollectionViewCell.swift
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

import UIKit

class HorizontalStringCollectionViewCell: UICollectionViewCell {

    typealias OnFocusAction = (Int) -> ()
    
    static let identifier = "HorizontalStringCollectionViewCell"

    var onFocusAction: OnFocusAction?
    var parentCollectionView: HorizontalStringCollectionView?
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard
            let nextFocused = context.nextFocusedView as? HorizontalStringCollectionViewCell,
            let prevFocused = context.previouslyFocusedView as? HorizontalStringCollectionViewCell
        else {
            if let horizontalColletion = context.previouslyFocusedView as? HorizontalStringCollectionView {
                horizontalColletion.fade()
            }
            return
        }
        
        let nextIndex = Int(nextFocused.accessibilityIdentifier ?? "0") ?? 0
        nextFocused.parentCollectionView?.clearAllCells()
        nextFocused.onFocusAction?(nextIndex)
        
        highlightCell(nextFocused)
        if prevFocused.parentCollectionView === nextFocused.parentCollectionView {
            unhighlightCell(prevFocused)
        } else {
            prevFocused.parentCollectionView?.fade()
        }
    }
    
    private func highlightCell(_ cell: HorizontalStringCollectionViewCell) {
        decorateCell(cell, focused: true)
    }
    
    private func unhighlightCell(_ cell: HorizontalStringCollectionViewCell) {
        decorateCell(cell, focused: false)
    }
    
    private func decorateCell(_ cell: HorizontalStringCollectionViewCell, focused: Bool) {
        guard
            let config = cell.parentCollectionView?.configuration
        else { return }

        cell.textLabel.font = focused ? config.focusedFont : config.normalFont
        cell.textLabel.textColor = focused ? config.focusedTextColor : config.normalTextColor
        cell.backgroundColor = focused ? config.focusedBgColor : config.normalBgColor
        cell.parentCollectionView?.collectionViewLayout.invalidateLayout()
    }
    
}
