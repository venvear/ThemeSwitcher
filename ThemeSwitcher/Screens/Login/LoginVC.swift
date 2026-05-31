//
//  LoginVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 06.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    private lazy var themeButtonView: UIView = {

        let button = UIButton(type: .system)
        button.setImage(UIImage.app(.theme), for: .normal)
        button.tintColor = UIColor.Pallete.primaryText
        button.addTarget(self, action: #selector(showThemePanel), for: .touchUpInside)
        button.extendHitTestAreaToMinVertically = true
        button.extendHitTestAreaToMinHorizontally = true
        button.accessibilityLabel = "Choose app appearance"
        
        let view = UIView()
        view.backgroundColor = UIColor.Pallete.appBackground
        
        view.addAutoLayoutSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "UIKit example\nThis screen demonstrates switching between system, light and dark themes."
        label.textColor = UIColor.Pallete.secondaryText
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
    private let loginImageView = UIImageView(image: UIImage.app(.login))
    private let loginTextField = TextFieldPadding(placeholder: "Username")
    private let passTextField = TextFieldPadding(placeholder: "Password")
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        
        loginImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginImageView.widthAnchor.constraint(equalToConstant: 80),
            loginImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
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
        configureFields()
        updateLoginButtonState()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissTap() {
        loginTextField.endEditing(true)
        passTextField.endEditing(true)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.appBackground
        
        [themeButtonView, descriptionLabel, stackView].forEach { view.addAutoLayoutSubview($0) }
        
        NSLayoutConstraint.activate([
            themeButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            themeButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            themeButtonView.widthAnchor.constraint(equalToConstant: 44),
            themeButtonView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: themeButtonView.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        loginTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64).isActive = true
        
        passTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64).isActive = true

        NSLayoutConstraint.activate([
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64),
            loginButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

    private func configureFields() {
        loginTextField.textContentType = .username
        loginTextField.returnKeyType = .next
        loginTextField.font = .preferredFont(forTextStyle: .body)
        loginTextField.adjustsFontForContentSizeCategory = true
        loginTextField.accessibilityLabel = "Username"

        passTextField.textContentType = .password
        passTextField.isSecureTextEntry = true
        passTextField.returnKeyType = .go
        passTextField.font = .preferredFont(forTextStyle: .body)
        passTextField.adjustsFontForContentSizeCategory = true
        passTextField.accessibilityLabel = "Password"

        loginTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    private func updateLoginButtonState(isLoading: Bool = false) {
        let canSubmit = !(loginTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        loginButton.isEnabled = canSubmit && !isLoading
        loginButton.backgroundColor = loginButton.isEnabled ? UIColor.Pallete.primaryText : UIColor.Pallete.separator
        loginButton.setTitleColor(UIColor.Pallete.inverseText, for: .normal)
        loginButton.accessibilityHint = canSubmit ? "Opens the main demo" : "Enter a username first"
    }

    @objc func textFieldDidChange() {
        updateLoginButtonState()
    }
    
    @objc func loginTapped() {
        dismissTap()

        let username = (loginTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !username.isEmpty else {
            updateLoginButtonState()
            return
        }
        
        User.current = User(name: username)
        
        let style: UIActivityIndicatorView.Style = .medium

        let aiView = UIActivityIndicatorView(style: style)
        aiView.startAnimating()
        loginButton.addAutoLayoutSubview(aiView)
        NSLayoutConstraint.activate([
            aiView.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
            aiView.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: -16)
        ])
        
        updateLoginButtonState(isLoading: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            (UIApplication.shared.delegate as? AppDelegate)?.showMainWindow()
        }
    }
    
    @objc func showThemePanel() {
        let vc = ThemePanelVC()
        present(vc, animated: true, completion: nil)
    }
}
