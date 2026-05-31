//
//  ThemeSwitcherTests.swift
//  ThemeSwitcherTests
//
//  Created by Codex on 31.05.2026.
//

import Foundation
import Testing
import UIKit
@testable import ThemeSwitcher

@MainActor
@Suite("ThemeSwitcher core behavior", .serialized)
struct ThemeSwitcherTests {

    @Test("Theme raw values remain stable")
    func themeRawValuesRemainStable() {
        #expect(Theme.system.rawValue == 0)
        #expect(Theme.light.rawValue == 1)
        #expect(Theme.dark.rawValue == 2)
        #expect(Theme.allCases == [.system, .light, .dark])
    }

    @Test("Theme display names match the selector labels")
    func themeDisplayNamesMatchSelectorLabels() {
        #expect(Theme.system.displayName == "System")
        #expect(Theme.light.displayName == "Light")
        #expect(Theme.dark.displayName == "Dark")
    }

    @Test("Theme accessibility labels are readable")
    func themeAccessibilityLabelsAreReadable() {
        #expect(Theme.system.accessibilityLabel == "System appearance")
        #expect(Theme.light.accessibilityLabel == "Light appearance")
        #expect(Theme.dark.accessibilityLabel == "Dark appearance")
    }

    @Test("Theme selection is persisted")
    func themeSelectionIsPersisted() {
        preservingUserDefault("app_theme") {
            Theme.dark.save()
            #expect(Theme.current == .dark)

            Theme.light.save()
            #expect(Theme.current == .light)
        }
    }

    @Test("ThemeManager maps themes to UIKit styles")
    func themeManagerMapsThemesToUIKitStyles() {
        let manager = ThemeManager.shared

        #expect(manager.userInterfaceStyle(for: .system) == .unspecified)
        #expect(manager.userInterfaceStyle(for: .light) == .light)
        #expect(manager.userInterfaceStyle(for: .dark) == .dark)
    }

    @Test("ThemeManager applies the current theme to supplied windows")
    func themeManagerAppliesCurrentThemeToSuppliedWindows() {
        preservingUserDefault("app_theme") {
            let window = UIWindow()

            Theme.dark.save()
            ThemeManager.shared.applyCurrentTheme(to: [window])
            #expect(window.overrideUserInterfaceStyle == .dark)

            Theme.system.save()
            ThemeManager.shared.applyCurrentTheme(to: [window])
            #expect(window.overrideUserInterfaceStyle == .unspecified)
        }
    }

    @Test("Current user reads and writes the persisted name")
    func currentUserReadsAndWritesPersistedName() throws {
        try preservingUserDefault("user_name") {
            User.current = nil
            #expect(User.current == nil)

            User.current = User(name: "")
            #expect(User.current == nil)

            User.current = User(name: "   ")
            #expect(User.current == nil)

            User.current = User(name: " andrey ")
            let currentUser = try #require(User.current)

            #expect(currentUser.name == "andrey")
            #expect(currentUser.email == "andrey@email.com")

            User.current = nil
            #expect(User.current == nil)
        }
    }

    @Test("Persist wrapper returns default and stores new values")
    func persistWrapperReturnsDefaultAndStoresNewValues() {
        preservingUserDefault(TestPersistStore.key) {
            var store = TestPersistStore()

            #expect(store.value == "fallback")

            store.value = "stored"

            #expect(UserDefaults.standard.string(forKey: TestPersistStore.key) == "stored")
            #expect(TestPersistStore().value == "stored")
        }
    }

    private func preservingUserDefault(_ key: String, run: () throws -> Void) rethrows {
        let defaults = UserDefaults.standard
        let previousValue = defaults.object(forKey: key)

        defaults.removeObject(forKey: key)
        defer {
            if let previousValue {
                defaults.set(previousValue, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }

        try run()
    }
}

private struct TestPersistStore {
    static let key = "ThemeSwitcherTests.persistedValue"

    @Persist(key: key, defaultValue: "fallback")
    var value: String
}
