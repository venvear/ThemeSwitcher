//
//  ThemeSwitcherTests.swift
//  ThemeSwitcherTests
//
//  Created by Codex on 31.05.2026.
//

import Foundation
import Testing
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

    @Test("Theme names match the selector labels")
    func themeNamesMatchSelectorLabels() {
        #expect(Theme.system.name == "System*")
        #expect(Theme.light.name == "Light")
        #expect(Theme.dark.name == "Dark")
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

    @Test("Current user reads and writes the persisted name")
    func currentUserReadsAndWritesPersistedName() throws {
        try preservingUserDefault("user_name") {
            User.current = nil
            #expect(User.current == nil)

            User.current = User(name: "andrey")
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
