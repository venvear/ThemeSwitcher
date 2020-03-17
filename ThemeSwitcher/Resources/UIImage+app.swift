//
//  UIImage+app.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension UIImage {
    
    enum AppImage: String, CaseIterable {
        // tabs
        case feed
        case profile
        
        case login
        case userInfo
        
        // buttons
        case theme
        case logout
        
        // avatars
        case avatar0, avatar1, avatar2, avatar3, avatar4, avatar5, avatar6
    }
    
    static func app(_ appImage: AppImage, rendering: RenderingMode = .automatic) -> UIImage? {
        return UIImage(named: appImage.rawValue, in: Bundle.main, compatibleWith: nil)?.withRenderingMode(rendering)
    }
}
