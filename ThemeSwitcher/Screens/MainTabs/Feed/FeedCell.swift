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
        
        [avatarImageView, nameLabel, timeLabel, descriptionLabel, separator].forEach(contentView.addSubview)
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().inset(12)
            make.width.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(12 + 48 + 12)
            make.top.equalToSuperview().inset(12)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.right).offset(4)
            make.top.equalToSuperview().inset(12)
            make.right.lessThanOrEqualToSuperview().inset(12)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.right.bottom.equalToSuperview().inset(12)
        }
        
        separator.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }

    func set(data feed: Feed) {
        avatarImageView.image = UIImage.app(feed.image)
        nameLabel.text = feed.name
        timeLabel.text = "• \(feed.date)"
        descriptionLabel.text = feed.text
        
    }
}
