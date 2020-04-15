//
//  AppDelegate.swift
//  MultiPickerDemo
//
//  Created by Filip Dujmušić on 18/08/2017.
//  Copyright © 2017 Ingemark. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.rootViewController = MainViewController()
            window.makeKeyAndVisible()
        }
        
        return true
        
    }

}

