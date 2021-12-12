//
//  AppDelegate.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

let themeWindow = ThemeWindow()

final class ThemeWindow: UIWindow {
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        // Если текущая тема системная и поменяли оформление в iOS, опять меняем тему на системную.
        // Например: Пользователь поменял светлое оформление на темное.
        if Theme.current == .system {
            DispatchQueue.main.async {
                Theme.system.setActive()
            }
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    @Persist(key: "authorized", defaultValue: false)
    private var isAuthorized: Bool
    
    private let iOS13OnlyWindow = UIWindow()
    private var loginWindow = UIWindow()
    private var mainWindow = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Добавляем окно к приложению, но не показываем его
        // Необходимо вызывать до установки главного окна приложения
        themeWindow.makeKey()
        
        guard #available(iOS 13.0, *) else {
            iOS13OnlyWindow.rootViewController = iOS13OnlyVC()
            iOS13OnlyWindow.makeKeyAndVisible()
            return true
        }
        
        if isAuthorized {
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
    }

    func showMainWindow() {
        isAuthorized = true
        
        mainWindow.rootViewController = MainTabsVC()
        mainWindow.initTheme()
        mainWindow.makeKeyAndVisible()
    }
}
