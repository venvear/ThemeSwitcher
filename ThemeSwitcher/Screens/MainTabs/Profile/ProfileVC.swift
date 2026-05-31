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
        return buttonItem
    }()
    
    private let profileImageView = UIImageView(image: UIImage.app(.userInfo))
    
    private lazy var userNameView: UIView = {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Username"
            label.textColor = UIColor.Pallete.black.withAlphaComponent(0.8)
            label.font = .systemFont(ofSize: 17)
            return label
        }()
        
        let valueLabel: UILabel = {
            let label = UILabel()
            label.text = User.current?.name ?? "empty"
            label.textColor = UIColor.Pallete.black
            label.font = .systemFont(ofSize: 17, weight: .medium)
            return label
        }()
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.background
        
        let separator = UIView()
        separator.backgroundColor = UIColor.Pallete.gray
        
        let bottomSeparator = UIView()
        bottomSeparator.backgroundColor = UIColor.Pallete.gray
        
        [separator, titleLabel, valueLabel, bottomSeparator].forEach { view.addAutoLayoutSubview($0) }
        
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.topAnchor.constraint(equalTo: view.topAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            label.textColor = UIColor.Pallete.black.withAlphaComponent(0.8)
            label.font = .systemFont(ofSize: 17)
            return label
        }()
        
        let valueLabel: UILabel = {
            let label = UILabel()
            label.text = User.current?.email ?? "empty"
            label.textColor = UIColor.Pallete.black
            label.font = .systemFont(ofSize: 17, weight: .medium)
            return label
        }()
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.background
        
        let separator = UIView()
        separator.backgroundColor = UIColor.Pallete.gray
        
        [separator, titleLabel, valueLabel].forEach { view.addAutoLayoutSubview($0) }
        
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
        view.backgroundColor = UIColor.Pallete.background
        
        view.addAutoLayoutSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60)
        ])
        
        userNameView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        emailView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
    }
    
    @objc func logoutTapped() {
        
        (UIApplication.shared.delegate as? AppDelegate)?.showLoginScreen()
    }
    
    
}
