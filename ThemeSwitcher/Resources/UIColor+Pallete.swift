//
//  UIColor.Pallete.shared.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension UIColor {
    
    struct Pallete {

        static let appBackground = UIColor(named: "appBackground") ?? UIColor.color(light: .white, dark: .hex("1b1b1d"))
        static let primaryText = UIColor(named: "primaryText") ?? UIColor.color(light: .black, dark: .white)
        static let secondaryText = UIColor(named: "secondaryText") ?? UIColor.color(light: .darkGray, dark: .lightGray)
        static let separator = UIColor(named: "separator") ?? UIColor.color(light: .lightGray, dark: .hex("8e8e92"))
        static let inverseText = UIColor(named: "inverseText") ?? UIColor.color(light: .white, dark: .black)

        static let white = inverseText
        static let black = primaryText
        static let background = appBackground
        static let secondaryBackground = UIColor(named: "secondaryBackground") ?? .black
        static let gray = separator

    }
}
