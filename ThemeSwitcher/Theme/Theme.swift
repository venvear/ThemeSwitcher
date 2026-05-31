//
//  Theme.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import Foundation

enum Theme: Int, CaseIterable {
    case system = 0
    case light
    case dark
}

@MainActor
extension Theme {

    @Persist(key: "app_theme", defaultValue: Theme.system.rawValue)
    private static var appTheme: Int

    var displayName: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var accessibilityLabel: String {
        "\(displayName) appearance"
    }

    func save() {
        Theme.appTheme = self.rawValue
    }

    static var current: Theme {
        Theme(rawValue: appTheme) ?? .system
    }
}
