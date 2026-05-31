//
//  FeedCell.swift
//  ThemeSwitcher
//
//  Created by Andrey Raevnev on 07.03.2020.
//  Copyright © 2020 Andrey Raevnev. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell, Reusable {
    
    private let avatarImageView: UIImageView = {
        let label = UIImageView()
        label.backgroundColor = UIColor.Pallete.background
        label.layer.cornerRadius = 24
        label.layer.borderColor = UIColor.Pallete.gray.cgColor
        label.layer.borderWidth = 1
        label.layer.masksToBounds = true
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "asdasda"
        label.textColor = UIColor.Pallete.black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "asdasda"
        label.textColor = UIColor.Pallete.gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "asdasda"
        label.textColor = UIColor.Pallete.black.withAlphaComponent(0.8)
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.Pallete.background
        
        let separator = UIView()
        separator.backgroundColor = UIColor.Pallete.gray
        
        [avatarImageView, nameLabel, timeLabel, descriptionLabel, separator].forEach {
            contentView.addAutoLayoutSubview($0)
        }
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48),
            avatarImageView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 72),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
    }

    func set(data feed: Feed) {
        avatarImageView.image = UIImage.app(feed.image)
        nameLabel.text = feed.name
        timeLabel.text = "• \(feed.date)"
        descriptionLabel.text = feed.text
        
    }
}
