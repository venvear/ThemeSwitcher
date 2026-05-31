//
//  AppDelegate.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    @Persist(key: "authorized", defaultValue: false)
    private var isAuthorized: Bool
    
    private let iOS13OnlyWindow = UIWindow()
    private var loginWindow = UIWindow()
    private var mainWindow = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if isAuthorized, User.current != nil {
            showMainWindow()
        } else {
            showLoginScreen()
        }
        
        return true
    }

    func showLoginScreen() {
        isAuthorized = false

        loginWindow.rootViewController = LoginVC()
        loginWindow.initTheme()
        loginWindow.makeKeyAndVisible()
        mainWindow.isHidden = true
    }

    func showMainWindow() {
        isAuthorized = true

        mainWindow.rootViewController = MainTabsVC()
        mainWindow.initTheme()
        mainWindow.makeKeyAndVisible()
        loginWindow.isHidden = true
    }
}
