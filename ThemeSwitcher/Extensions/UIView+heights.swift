//
//  UIView+heights.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension UIView {
    
    static var navbarHeight: CGFloat { 44 }
    
    static var topSafeAreaHeight: CGFloat { UIDevice.iPhoneX ? 44 : 20 }
    
    static var bottomSafeAreaHeight: CGFloat { UIDevice.iPhoneX ? 34 : 0 }
    
}
