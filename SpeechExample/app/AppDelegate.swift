//
//  AppDelegate.swift
//  SpeechExample
//
//  Created by ablett on 2019/7/11.
//  Copyright © 2019 ablett.chen@gmail.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        launch(rootController: UINavigationController.init(rootViewController: ExampleViewController()))
        
        return true
    }
    
    private func launch(rootController: UIViewController) {
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        self.window!.backgroundColor = UIColor.init(argb: 0xffffffff)
        self.window!.rootViewController = rootController
        self.window!.makeKeyAndVisible()
    }
}

