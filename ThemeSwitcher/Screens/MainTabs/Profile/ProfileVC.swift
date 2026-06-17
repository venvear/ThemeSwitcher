//
//  ProfileVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    private lazy var logoutButton: UIBarButtonItem = {
        let buttonItem = UIBarButtonItem(image: UIImage.app(.logout), style: .plain, target: self, action: #selector(logoutTapped))
        buttonItem.tintColor = UIColor.systemRed
        buttonItem.accessibilityLabel = "Log out"
        return buttonItem
    }()
    
    private let profileImageView = UIImageView(image: UIImage.app(.userInfo))
    
    private lazy var userNameView: UIView = {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Username"
            label.textColor = UIColor.Pallete.secondaryText
            label.font = .preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = 0
            return label
        }()
        
        let valueLabel: UILabel = {
            let label = UILabel()
            label.text = User.current?.name ?? "empty"
            label.textColor = UIColor.Pallete.primaryText
            label.font = .preferredFont(forTextStyle: .headline)
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = 0
            label.textAlignment = .right
            return label
        }()
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.appBackground
        view.isAccessibilityElement = true
        view.accessibilityLabel = "Username, \(User.current?.name ?? "empty")"
        
        let separator = UIView()
        separator.backgroundColor = UIColor.Pallete.separator
        
        let bottomSeparator = UIView()
        bottomSeparator.backgroundColor = UIColor.Pallete.separator
        
        [separator, titleLabel, valueLabel, bottomSeparator].forEach { view.addAutoLayoutSubview($0) }
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 56),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.topAnchor.constraint(equalTo: view.topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            valueLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 12),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            bottomSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bottomSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomSeparator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        return view
    }()
    
    private lazy var emailView: UIView = {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Email"
            label.textColor = UIColor.Pallete.secondaryText
            label.font = .preferredFont(forTextStyle: .body)
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = 0
            return label
        }()
        
        let valueLabel: UILabel = {
            let label = UILabel()
            label.text = User.current?.email ?? "empty"
            label.textColor = UIColor.Pallete.primaryText
            label.font = .preferredFont(forTextStyle: .headline)
            label.adjustsFontForContentSizeCategory = true
            label.numberOfLines = 0
            label.textAlignment = .right
            return label
        }()
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.appBackground
        view.isAccessibilityElement = true
        view.accessibilityLabel = "Email, \(User.current?.email ?? "empty")"
        
        let separator = UIView()
        separator.backgroundColor = UIColor.Pallete.separator
        
        [separator, titleLabel, valueLabel].forEach { view.addAutoLayoutSubview($0) }
        
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 56),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.centerXAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            valueLabel.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 12),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -12)
        ])
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 80),
            profileImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let st = UIStackView(arrangedSubviews: [profileImageView, FixedHeightView(height: 48),
                                                userNameView, emailView])
        st.axis = .vertical
        st.spacing = 0
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = logoutButton

        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.appBackground
        
        view.addAutoLayoutSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            userNameView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emailView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
    }
    
    @objc func logoutTapped() {
        User.current = nil
        (UIApplication.shared.delegate as? AppDelegate)?.showLoginScreen()
    }
    
    
}
