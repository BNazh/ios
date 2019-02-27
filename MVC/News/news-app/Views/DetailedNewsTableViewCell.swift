//
//  DetailedNewsTableViewCell.swift
//  SDU Connect
//
//  Created by  Nazhmeddin Babakhanov  on 11/13/17.
//  Copyright © 2017 Nolan. All rights reserved.
//

import UIKit
import Cartography

class DetailedNewsTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    static var identifier: String {
        return "DetailedNewsTableViewCell"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProTextSemibold(ofSize: 19)
        label.textColor = .black
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProTextLight(ofSize: 11)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .sfProTextLight(ofSize: 11)
        label.textColor = .mainBlue
        label.text = "bnews.kz"
        label.textAlignment = .left
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var shortLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.font = .sfProTextRegular(ofSize: 16)
        bodyLabel.numberOfLines = 0
        bodyLabel.sizeToFit()
        bodyLabel.textColor = .black
        bodyLabel.textAlignment = .left
        return bodyLabel
    }()
    
    lazy var bodyLabel: UILabel = {
        let bodyLabel = UILabel()
        bodyLabel.font = .sfProTextRegular(ofSize: 16)
        bodyLabel.numberOfLines = 0
        bodyLabel.sizeToFit()
        bodyLabel.textColor = .black
        bodyLabel.textAlignment = .left
        return bodyLabel
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
        [dateLabel, sourceLabel, titleLabel, shortLabel, lineView, bodyLabel].forEach { view in
            contentView.addSubview(view)
        }
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        constrain(dateLabel, sourceLabel, titleLabel, contentView) { dateLabel, sourceLabel, titleLabel, contentView in
            dateLabel.top == contentView.top + 10
            dateLabel.left == contentView.left + 21
            dateLabel.width == 110
            dateLabel.height == 10
            
            sourceLabel.top == dateLabel.top
            sourceLabel.left == dateLabel.right + 2
            sourceLabel.width == 50
            sourceLabel.height == 10
            
            titleLabel.top == dateLabel.bottom + 10
            titleLabel.left == contentView.left + 21
            titleLabel.right == contentView.right - 21
            titleLabel.height == 70
        }
        
        constrain(shortLabel, lineView, bodyLabel, titleLabel, contentView) { sourceLabel, lineView, bodyLabel, titleLabel, contentView in
            sourceLabel.top == titleLabel.bottom + 5
            sourceLabel.left == contentView.left + 21
            sourceLabel.right == contentView.right - 21
            sourceLabel.height == 70
            
            lineView.height == 1
            lineView.width == 80
            lineView.top == sourceLabel.bottom + 10
            lineView.centerX == contentView.centerX
            
            bodyLabel.top == lineView.bottom + 10
            bodyLabel.left == contentView.left + 21
            bodyLabel.right == contentView.right - 21
            bodyLabel.bottom == contentView.bottom
        }
    }
    
}

