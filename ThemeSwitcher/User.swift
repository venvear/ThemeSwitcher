//
//  User.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import Foundation

struct User {
    let name: String
    
    var email: String { "\(name)@email.com" }
}


@MainActor
extension User {
    
    @Persist(key: "user_name", defaultValue: "")
    private static var name: String
    
    static var current: User? {
        get {
            let persistedName = User.name.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !persistedName.isEmpty else { return nil }
            return User(name: persistedName)
        }
        set {
            User.name = newValue?.name.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        }
    }
    
}
