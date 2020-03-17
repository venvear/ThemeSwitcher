//
//  MainTabsVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit
import SnapKit

class MainTabsVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabs()
        updateColors()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        updateColors()
    }
    
    private func updateColors() {
        tabBar.tintColor = UIColor.Pallete.black
        tabBar.backgroundImage = UIImage.by(color: UIColor.Pallete.secondaryBackground)
        view.backgroundColor = UIColor.Pallete.secondaryBackground
    }
    
    private func setTabs() {
        
        func createTab(_ vc: UIViewController, _ title: String, _ image: UIImage?) -> UINavigationController {
            let nc = MainNC(rootViewController: vc)
            nc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
            vc.navigationItem.title = title
            
            let buttonItem = UIBarButtonItem(image: UIImage.app(.theme), style: .plain, target: self, action: #selector(showThemePanel))
            buttonItem.tintColor = UIColor.Pallete.black
            vc.navigationItem.rightBarButtonItem = buttonItem
            
            return nc
        }
        
        let feedTab = createTab(FeedVC(), "Feed", UIImage.app(.feed))
        let profileTab = createTab(ProfileVC(), "Profile", UIImage.app(.profile))

        setViewControllers([feedTab, profileTab], animated: false)
    }
    
    @objc func showThemePanel() {
        let vc = ThemePanelVC()
        present(vc, animated: true, completion: nil)
    }
}

class MainNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.Pallete.secondaryBackground
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        navigationBar.barTintColor = UIColor.Pallete.secondaryBackground
    }
    
}
