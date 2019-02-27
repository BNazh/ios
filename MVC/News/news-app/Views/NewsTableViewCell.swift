//
//  NewsTableViewCell.swift
//  SDU Connect
//
//  Created by Nazhmeddin Babakhanov on 11/13/17.
//  Copyright © 2017 Nolan. All rights reserved.
//

import UIKit
import Cartography
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        return "NewsTableViewCell"
    }
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.kf.indicatorType = .activity
        imageView.image = #imageLiteral(resourceName: "bnews")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProTextRegular(ofSize: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProTextRegular(ofSize: 12)
        label.textColor = .dateGray
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Inital Setup
    func setupViews() {
        [newsImageView, titleLabel, dateLabel].forEach { (view) in
            contentView.addSubview(view)
        }
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        constrain(newsImageView, titleLabel, dateLabel, contentView) { newsImageView, titleLabel, dateLabel, contentView in
            newsImageView.left == contentView.left + 20
            newsImageView.width == 60
            newsImageView.height == 60
            newsImageView.centerY == contentView.centerY
            
            dateLabel.left == newsImageView.right + 20
            dateLabel.height == 14
            dateLabel.bottom == newsImageView.bottom
            
            titleLabel.left == newsImageView.right + 20
            titleLabel.right == contentView.right - 36
            titleLabel.top == newsImageView.top
            titleLabel.bottom == dateLabel.top + 1
        }
    }
}
