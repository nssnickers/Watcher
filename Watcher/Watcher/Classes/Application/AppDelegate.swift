//
//  AppDelegate.swift
//  Watcher
//
//  Created by Маргарита on 10/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let authViewController = AuthViewController(nibName: nil, bundle: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = authViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
