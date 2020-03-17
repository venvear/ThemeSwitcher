//
//  UIApplication+Theme.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension Theme {
    
    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .system: return themeWindow.traitCollection.userInterfaceStyle
        }
    }
    
    func setActive() {
        // Сохраняем активную тему
        save()
        
        guard #available(iOS 13.0, *) else { return }
        
        // Устанавливаем активную тему для всех окон приложения
        UIApplication.shared.windows
            .filter { $0 != themeWindow } // не красим это окно чтобы узнавать системную тему
            .forEach { $0.overrideUserInterfaceStyle = userInterfaceStyle }
    }
}
