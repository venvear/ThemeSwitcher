//
//  UIWindow+theme.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 15.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension UIWindow {

    func initTheme() {
        overrideUserInterfaceStyle = Theme.current.userInterfaceStyle
    }
}
