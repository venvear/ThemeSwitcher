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

        static let white = UIColor.color(light: .white, dark: .black)
        static let black = UIColor.color(light: .black, dark: .white)

        static let background = UIColor.color(light: .white, dark: .hex("1b1b1d"))
        static let secondaryBackground = UIColor(named: "secondaryBackground") ?? .black

        static let gray = UIColor.color(light: .lightGray, dark: .hex("8e8e92"))

    }
}
