//
//  iOS13OnlyVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit
import SnapKit

class iOS13OnlyVC: UIViewController {
    
    private lazy var descriptionLabel: UIView = {
        let label = UILabel()
        label.text = "The application is available only in iOS 13"
        label.textColor = UIColor.Pallete.black
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.background
        
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(24)
        }
    }
}
