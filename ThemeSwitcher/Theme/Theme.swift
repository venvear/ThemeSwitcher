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

    var detailText: String {
        switch self {
        case .system:
            return "Follows the current iOS appearance and updates when the device changes."
        case .light:
            return "Keeps the app in light appearance until another mode is selected."
        case .dark:
            return "Keeps the app in dark appearance until another mode is selected."
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

struct ThemeAuditItem: Hashable {
    let title: String
    let detail: String

    var accessibilityLabel: String {
        "\(title). \(detail)"
    }

    static let defaultItems: [ThemeAuditItem] = [
        ThemeAuditItem(
            title: "Use semantic color tokens",
            detail: "Define app colors once in the asset catalog, then reference them from UIKit and SwiftUI."
        ),
        ThemeAuditItem(
            title: "Cover every appearance mode",
            detail: "Smoke-test System, Light and Dark so forced styles and device settings behave as expected."
        ),
        ThemeAuditItem(
            title: "Keep assets adaptive",
            detail: "Provide light and dark variants for images that depend on background contrast."
        ),
        ThemeAuditItem(
            title: "Respect accessibility settings",
            detail: "Verify Dynamic Type, VoiceOver labels and non-color cues on every themed screen."
        )
    ]
}
