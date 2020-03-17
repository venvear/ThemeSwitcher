//
//  ThemePanelVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit
import SnapKit

extension Theme {
    
    var name: String {
        switch self {
        case .system: return "System*"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }
}


class ThemePanelVC: BottomModalVC {
    
    override var containerView: UIView { rootContainerView }
    override var containerHeight: CGFloat { 160 }
    
    private lazy var themeSegmentedControl: UISegmentedControl = {
        let segmentedView = UISegmentedControl(items: Theme.allCases.map { $0.name })
        segmentedView.tintColor = UIColor.Pallete.black
        segmentedView.selectedSegmentIndex = Theme.current.rawValue
        segmentedView.addTarget(self, action: #selector(selectTheme), for: .valueChanged)
        return segmentedView
    }()
    
    lazy var rootContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.background
        
        let label = UILabel()
        label.text = "Theme"
        label.textColor = UIColor.Pallete.black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        let systemThemelabel = UILabel()
        systemThemelabel.text = "* System theme - the app's appearance will change automatically when you enable or disable iOS dark mode."
        systemThemelabel.textColor = UIColor.Pallete.black.withAlphaComponent(0.6)
        systemThemelabel.font = .systemFont(ofSize: 13)
        systemThemelabel.numberOfLines = 0
        
        [label, themeSegmentedControl, systemThemelabel].forEach(view.addSubview)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.centerX.equalToSuperview()
        }
        
        themeSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        systemThemelabel.snp.makeConstraints {
            $0.top.equalTo(themeSegmentedControl.snp.bottom).offset(16)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        return view
    }()
    
    @objc func selectTheme() {
        guard let theme = Theme(rawValue: themeSegmentedControl.selectedSegmentIndex) else { return }
        
        theme.setActive()
    }
    
}
