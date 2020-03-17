//
//  LoginVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    let interactor = Interactor()
    
    private lazy var themeButtonView: UIView = {

        let button = UIButton(type: .system)
        button.setImage(UIImage.app(.theme), for: .normal)
        button.tintColor = UIColor.Pallete.black
        button.addTarget(self, action: #selector(showThemePanel), for: .touchUpInside)
        button.extendHitTestAreaToMinVertically = true
        button.extendHitTestAreaToMinHorizontally = true
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.background
        
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This application is an example of implementing support for a dark theme.\nShown here is switching between system, light and dark themes."
        label.textColor = UIColor.Pallete.black.withAlphaComponent(0.6)
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private let loginImageView = UIImageView(image: UIImage.app(.login))
    private let loginTextField = TextFieldPadding(placeholder: "Username")
    private let passTextField = TextFieldPadding(placeholder: "Password")
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.Pallete.black
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.Pallete.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        
        loginImageView.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
        
        let st = UIStackView(arrangedSubviews: [loginImageView, FixedHeightView(height: 32),
                                                loginTextField, FixedHeightView(height: 16),
                                                passTextField, FixedHeightView(height: 32),
                                                loginButton])
        st.axis = .vertical
        st.spacing = 0
        st.alignment = .center
        st.distribution = .fill
        return st
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissTap() {
        loginTextField.endEditing(true)
        passTextField.endEditing(true)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.background
        
        [themeButtonView, descriptionLabel, stackView].forEach(view.addSubview)
        
        themeButtonView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.right.equalToSuperview().inset(8)
            $0.width.height.equalTo(44)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(themeButtonView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(24)
        }
        
        loginTextField.snp.makeConstraints {
            $0.width.equalTo(view).offset(-64)
        }
        
        passTextField.snp.makeConstraints {
            $0.width.equalTo(view).offset(-64)
        }

        loginButton.snp.makeConstraints {
            $0.width.equalTo(view).offset(-64)
            $0.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
    }
    
    @objc func loginTapped() {
        dismissTap()
        
        User.current = User(name: loginTextField.text ?? "")
        
        let style: UIActivityIndicatorView.Style
        if #available(iOS 13.0, *) {
            style = Theme.current.userInterfaceStyle == .dark ? .gray : .white
        } else {
            style = .gray
        }

        let aiView = UIActivityIndicatorView(style: style)
        aiView.startAnimating()
        loginButton.addSubview(aiView)
        aiView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(16)
        }
        
        loginButton.isUserInteractionEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            (UIApplication.shared.delegate as? AppDelegate)?.showMainWindow()
        }
    }
    
    @objc func showThemePanel() {
        let vc = ThemePanelVC()
        present(vc, animated: true, completion: nil)
    }
}
