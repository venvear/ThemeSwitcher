//
//  ThemePanelVC.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class ThemePanelVC: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .pageSheet
    }

    private lazy var themeSegmentedControl: UISegmentedControl = {
        let segmentedView = UISegmentedControl(items: Theme.allCases.map(\.displayName))
        segmentedView.selectedSegmentIndex = Theme.current.rawValue
        segmentedView.selectedSegmentTintColor = UIColor.Pallete.primaryText.withAlphaComponent(0.16)
        segmentedView.addTarget(self, action: #selector(selectTheme), for: .valueChanged)
        segmentedView.accessibilityLabel = "App appearance"
        return segmentedView
    }()

    private let selectedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Pallete.primaryText
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.accessibilityTraits = .header
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "System follows the current iOS appearance. Light and Dark keep the app fixed until you change it again."
        label.textColor = UIColor.Pallete.secondaryText
        label.font = .preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSheet()
        setupViews()
        updateSelectedThemeLabel()
    }

    private func setupSheet() {
        guard let sheetPresentationController else { return }

        sheetPresentationController.detents = [.medium()]
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.preferredCornerRadius = 16
    }

    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.appBackground

        let titleLabel = UILabel()
        titleLabel.text = "Appearance"
        titleLabel.textColor = UIColor.Pallete.primaryText
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.adjustsFontForContentSizeCategory = true

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            themeSegmentedControl,
            selectedLabel,
            descriptionLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.setCustomSpacing(24, after: titleLabel)

        view.addAutoLayoutSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func updateSelectedThemeLabel() {
        let theme = Theme.current
        selectedLabel.text = "Selected: \(theme.displayName)"
        descriptionLabel.text = theme.detailText
        themeSegmentedControl.accessibilityValue = theme.displayName
        themeSegmentedControl.accessibilityHint = theme.detailText
    }

    @objc func selectTheme() {
        guard let theme = Theme(rawValue: themeSegmentedControl.selectedSegmentIndex) else { return }

        theme.setActive()
        updateSelectedThemeLabel()
        UIAccessibility.post(notification: .announcement, argument: "\(theme.displayName) appearance selected")
    }
}
