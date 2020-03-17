//
//  ProfileVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit
import SnapKit

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
        
        [separator, titleLabel, valueLabel, bottomSeparator].forEach(view.addSubview)
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(48)
        }
        
        separator.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        bottomSeparator.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
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
        
        [separator, titleLabel, valueLabel].forEach(view.addSubview)
        
        view.snp.makeConstraints { (make) in
            make.height.equalTo(48)
        }
        
        separator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        
        profileImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
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
        
        [stackView].forEach(view.addSubview)
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
        }
        
        userNameView.snp.makeConstraints {
            $0.width.equalTo(view)
        }
        
        emailView.snp.makeConstraints {
            $0.width.equalTo(view)
        }
        
    }
    
    @objc func logoutTapped() {
        
        (UIApplication.shared.delegate as? AppDelegate)?.showLoginScreen()
    }
    
    
}
