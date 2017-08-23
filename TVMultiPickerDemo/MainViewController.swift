//
//  ViewController.swift
//  TVMultiPickerDemo
//
//  Created by Filip Dujmušić on 18/08/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//

import UIKit
import SnapKit
import TVMultiPicker

class MainViewController: UIViewController {
    
    var openPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pick date!", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton()
    }
    
    private func addButton() {
        view.addSubview(openPickerButton)
        openPickerButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc
    private func buttonTapped() {
        let picker = MultiPicker.datePicker { date, picker in
            self.dismiss(animated: true, completion: nil)
            guard
                let date = date
                else { return }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            
            self.openPickerButton.setTitle(dateFormatter.string(from: date), for: .normal)
        }
        present(picker, animated: true, completion: nil)
    }
    
}



