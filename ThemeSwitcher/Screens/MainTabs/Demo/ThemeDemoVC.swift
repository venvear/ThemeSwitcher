//
//  ThemeDemoVC.swift
//  ThemeSwitcher
//
//  Created by Codex on 31.05.2026.
//  Copyright © 2026 Andrey Raevnev. All rights reserved.
//

import UIKit

class ThemeDemoVC: UIViewController {

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        view.backgroundColor = UIColor.Pallete.appBackground
    }

    private func setupViews() {
        view.backgroundColor = UIColor.Pallete.appBackground

        contentStackView.axis = .vertical
        contentStackView.spacing = 24
        contentStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 24, leading: 20, bottom: 32, trailing: 20)
        contentStackView.isLayoutMarginsRelativeArrangement = true

        view.addAutoLayoutSubview(scrollView)
        scrollView.addAutoLayoutSubview(contentStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])

        contentStackView.addArrangedSubview(makeHeaderView())
        contentStackView.addArrangedSubview(makeColorSection(title: "App semantic colors", colors: [
            ColorSample(title: "appBackground", color: UIColor.Pallete.appBackground),
            ColorSample(title: "primaryText", color: UIColor.Pallete.primaryText),
            ColorSample(title: "secondaryText", color: UIColor.Pallete.secondaryText),
            ColorSample(title: "separator", color: UIColor.Pallete.separator)
        ]))
        contentStackView.addArrangedSubview(makeColorSection(title: "UIKit semantic colors", colors: [
            ColorSample(title: "systemBackground", color: .systemBackground),
            ColorSample(title: "label", color: .label),
            ColorSample(title: "secondaryLabel", color: .secondaryLabel),
            ColorSample(title: "systemBlue", color: .systemBlue)
        ]))
        contentStackView.addArrangedSubview(makeAuditChecklistSection())
        contentStackView.addArrangedSubview(makeAdaptiveImageSection())
        contentStackView.addArrangedSubview(makeComponentSection())
    }

    private func makeHeaderView() -> UIView {
        let titleLabel = UILabel()
        titleLabel.text = "Theme demo"
        titleLabel.textColor = UIColor.Pallete.primaryText
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Current mode: \(Theme.current.displayName). Change it from the toolbar to see colors, images and controls adapt."
        subtitleLabel.textColor = UIColor.Pallete.secondaryText
        subtitleLabel.font = .preferredFont(forTextStyle: .body)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }

    private func makeColorSection(title: String, colors: [ColorSample]) -> UIView {
        let titleLabel = makeSectionTitle(title)

        let gridStackView = UIStackView()
        gridStackView.axis = .vertical
        gridStackView.spacing = 12

        stride(from: 0, to: colors.count, by: 2).forEach { index in
            let row = UIStackView()
            row.axis = .horizontal
            row.spacing = 12
            row.distribution = .fillEqually
            row.addArrangedSubview(ColorSampleView(sample: colors[index]))

            if colors.indices.contains(index + 1) {
                row.addArrangedSubview(ColorSampleView(sample: colors[index + 1]))
            } else {
                row.addArrangedSubview(UIView())
            }

            gridStackView.addArrangedSubview(row)
        }

        let stackView = UIStackView(arrangedSubviews: [titleLabel, gridStackView])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }

    private func makeAuditChecklistSection() -> UIView {
        let titleLabel = makeSectionTitle("Theme audit checklist")

        let subtitleLabel = UILabel()
        subtitleLabel.text = "Reusable checks to run when adding this theme switcher to another screen."
        subtitleLabel.textColor = UIColor.Pallete.secondaryText
        subtitleLabel.font = .preferredFont(forTextStyle: .footnote)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0

        let itemsStackView = UIStackView()
        itemsStackView.axis = .vertical
        itemsStackView.spacing = 10

        ThemeAuditItem.defaultItems.forEach {
            itemsStackView.addArrangedSubview(ThemeAuditChecklistRow(item: $0))
        }

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, itemsStackView])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }

    private func makeAdaptiveImageSection() -> UIView {
        let titleLabel = makeSectionTitle("Adaptive image")

        let imageView = UIImageView(image: UIImage.app(.login))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.Pallete.secondaryBackground
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.isAccessibilityElement = true
        imageView.accessibilityLabel = "Login artwork changes between light and dark appearances"

        let captionLabel = UILabel()
        captionLabel.text = "The asset catalog provides separate light and dark versions for this image."
        captionLabel.textColor = UIColor.Pallete.secondaryText
        captionLabel.font = .preferredFont(forTextStyle: .footnote)
        captionLabel.adjustsFontForContentSizeCategory = true
        captionLabel.numberOfLines = 0

        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 160)
        ])

        let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, captionLabel])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }

    private func makeComponentSection() -> UIView {
        let titleLabel = makeSectionTitle("Controls")

        let textField = TextFieldPadding(placeholder: "Adaptive text field")
        textField.font = .preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true

        let button = UIButton(type: .system)
        button.setTitle("Primary action", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.backgroundColor = UIColor.Pallete.primaryText
        button.setTitleColor(UIColor.Pallete.inverseText, for: .normal)
        button.layer.cornerRadius = 8

        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])

        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField, button])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }

    private func makeSectionTitle(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = UIColor.Pallete.primaryText
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }
}

private struct ColorSample {
    let title: String
    let color: UIColor
}

private final class ColorSampleView: UIView {

    init(sample: ColorSample) {
        super.init(frame: .zero)

        backgroundColor = UIColor.Pallete.secondaryBackground
        layer.cornerRadius = 8

        let swatchView = UIView()
        swatchView.backgroundColor = sample.color
        swatchView.layer.cornerRadius = 8
        swatchView.layer.borderColor = UIColor.Pallete.separator.cgColor
        swatchView.layer.borderWidth = 1

        let titleLabel = UILabel()
        titleLabel.text = sample.title
        titleLabel.textColor = UIColor.Pallete.primaryText
        titleLabel.font = .preferredFont(forTextStyle: .footnote)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0

        let stackView = UIStackView(arrangedSubviews: [swatchView, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true

        addAutoLayoutSubview(stackView)
        NSLayoutConstraint.activate([
            swatchView.heightAnchor.constraint(equalToConstant: 44),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        isAccessibilityElement = true
        accessibilityLabel = sample.title
    }

    required init?(coder: NSCoder) { fatalError() }
}

private final class ThemeAuditChecklistRow: UIView {

    init(item: ThemeAuditItem) {
        super.init(frame: .zero)

        backgroundColor = UIColor.Pallete.secondaryBackground
        layer.cornerRadius = 8

        let iconImageView = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
        iconImageView.tintColor = UIColor.Pallete.primaryText
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.setContentHuggingPriority(.required, for: .horizontal)
        iconImageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        iconImageView.isAccessibilityElement = false

        let titleLabel = UILabel()
        titleLabel.text = item.title
        titleLabel.textColor = UIColor.Pallete.primaryText
        titleLabel.font = .preferredFont(forTextStyle: .subheadline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 0

        let detailLabel = UILabel()
        detailLabel.text = item.detail
        detailLabel.textColor = UIColor.Pallete.secondaryText
        detailLabel.font = .preferredFont(forTextStyle: .footnote)
        detailLabel.adjustsFontForContentSizeCategory = true
        detailLabel.numberOfLines = 0

        let textStackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        textStackView.axis = .vertical
        textStackView.spacing = 4

        let rowStackView = UIStackView(arrangedSubviews: [iconImageView, textStackView])
        rowStackView.axis = .horizontal
        rowStackView.alignment = .top
        rowStackView.spacing = 10
        rowStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        rowStackView.isLayoutMarginsRelativeArrangement = true

        addAutoLayoutSubview(rowStackView)
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 22),
            rowStackView.topAnchor.constraint(equalTo: topAnchor),
            rowStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rowStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rowStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        isAccessibilityElement = true
        accessibilityLabel = item.accessibilityLabel
    }

    required init?(coder: NSCoder) { fatalError() }
}
