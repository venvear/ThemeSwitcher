//
//  UITextFieldPadding.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class TextFieldPadding : UITextField {
    
    private let padding: UIEdgeInsets
    
    init(padding: UIEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8), placeholder: String = "") {
        self.padding = padding
        super.init(frame: .zero)
        
        layer.borderColor = UIColor.Pallete.black.withAlphaComponent(0.5).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        
        self.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.padding = .zero
        super.init(coder: aDecoder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        layer.borderColor = UIColor.Pallete.black.withAlphaComponent(0.5).cgColor
        
    }
}
