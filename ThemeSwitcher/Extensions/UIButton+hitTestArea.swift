//
//  UIButton+hitTestArea.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

extension UIButton {

    private struct AssociationKey {
        static var y = "y"
        static var x = "x"
    }

    public var extendHitTestAreaToMinVertically: Bool {
        get {
            let y = objc_getAssociatedObject(self, &AssociationKey.y) as? Bool
            return y ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociationKey.y, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public var extendHitTestAreaToMinHorizontally: Bool {
        get {
            let x = objc_getAssociatedObject(self, &AssociationKey.x) as? Bool
            return x ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociationKey.x, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden || !self.isUserInteractionEnabled || self.alpha.isZero { return nil }

        // минимальный размер области для тапа, рекомендуемый Apple
        let minimumHitArea = CGSize(width: 44, height: 44)
        let buttonSize = self.bounds.size

        var widthToAdd: CGFloat = 0
        var heightToAdd: CGFloat = 0

        if extendHitTestAreaToMinHorizontally {
            widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
        }
        if extendHitTestAreaToMinVertically {
            heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
        }

        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)

        return (largerFrame.contains(point)) ? self : nil
    }
}
