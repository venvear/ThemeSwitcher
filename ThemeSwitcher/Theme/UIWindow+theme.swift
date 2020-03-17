//
//  UIWindow+theme.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 15.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension UIWindow {
    
    // Устанавливаем текущую тему для окна
    // Необходимо вызывать перед показом окна
    func initTheme() {
        guard #available(iOS 13.0, *) else { return }
        
        overrideUserInterfaceStyle = Theme.current.userInterfaceStyle
    }
}
