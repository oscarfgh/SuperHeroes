//
//  AppDelegate.swift
//  Superheroes
//
//  Created by Oscar on 16/5/18.
//  Copyright © 2018 Oscar García. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            setupAppearance()
        
            window = UIWindow(frame: UIScreen.main.bounds)
            if let window = window {
                guard
                    let navController: UINavigationController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController() as? UINavigationController,
                    let viewController: ListViewController = navController.childViewControllers.first as? ListViewController else {
                        fatalError("Not load ListViewController")
                }
                
                ListConnector().wireUp(viewController)
                
                window.rootViewController = navController
                window.makeKeyAndVisible()
            }
        return true
    }
    
    func setupAppearance() {
        UINavigationBar.appearance().barTintColor = Color.primary
        UINavigationBar.appearance().tintColor = Color.white
        
        guard let font = UIFont(name: "Spider-Man", size: 32.0) else {
            return
        }
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: Color.white,
                                                            NSAttributedStringKey.font: font]
    }
}

