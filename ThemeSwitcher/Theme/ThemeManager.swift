//
//  ThemeManager.swift
//  ThemeSwitcher
//
//  Created by Codex on 31.05.2026.
//  Copyright © 2026 Andrey Raevnev. All rights reserved.
//

import UIKit

@MainActor
final class ThemeManager {

    static let shared = ThemeManager()

    private init() {}

    func apply(_ theme: Theme) {
        theme.save()
        applyCurrentTheme()
    }

    func applyCurrentTheme(to windows: [UIWindow]? = nil) {
        windowsToUpdate(from: windows).forEach {
            $0.overrideUserInterfaceStyle = Theme.current.userInterfaceStyle
        }
    }

    func observeSystemAppearanceIfNeeded() {
        applyCurrentTheme()
    }

    func userInterfaceStyle(for theme: Theme) -> UIUserInterfaceStyle {
        switch theme {
        case .system: return .unspecified
        case .light: return .light
        case .dark: return .dark
        }
    }

    private func windowsToUpdate(from windows: [UIWindow]?) -> [UIWindow] {
        if let windows {
            return windows
        }

        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap(\.windows)
    }
}
