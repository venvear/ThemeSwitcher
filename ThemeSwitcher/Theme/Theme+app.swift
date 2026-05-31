//
//  UIApplication+Theme.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

@MainActor
extension Theme {

    var userInterfaceStyle: UIUserInterfaceStyle {
        ThemeManager.shared.userInterfaceStyle(for: self)
    }

    func setActive() {
        ThemeManager.shared.apply(self)
    }
}
