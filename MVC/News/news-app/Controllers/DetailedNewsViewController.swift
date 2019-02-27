//
//  DetailedNewsViewController.swift
//  SDU Connect
//
//  Created by  Nazhmeddin Babakhanov  on 11/13/17.
//  Copyright © 2017 Nolan. All rights reserved.
//

import UIKit
import Cartography
import ParallaxHeader
import BulletinBoard
import Alamofire

class DetailedNewsViewController: UIViewController {
    
    // MARK: - Properties
    var newsObject: News?
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.kf.indicatorType = .activity
        return imageView
    }()
    
    lazy var successItem: PageBulletinItem = {
        let successItem: PageBulletinItem = PageBulletinItem(title: "Report sent")
        successItem.nextItem = PageBulletinItem(title: "Report sent")
        successItem.descriptionText = "Report successfully sent"
        successItem.actionButtonTitle = "Dismiss"
        successItem.image = #imageLiteral(resourceName: "success")
        successItem.interfaceFactory.actionButtonTitleColor = .white
        successItem.interfaceFactory.tintColor = .actionGreen
        successItem.actionHandler = { item in
            successItem.manager?.dismissBulletin(animated: true)
        }
        return successItem
    }()
    
    lazy var rootItem: BulletinItem = {
        let rootItem: PageBulletinItem = PageBulletinItem(title: "Report an error")
        rootItem.nextItem = successItem
        rootItem.image = #imageLiteral(resourceName: "error")
        rootItem.descriptionText = "If a news misclassified you can send a report"
        rootItem.actionButtonTitle = "Send"
        rootItem.alternativeButtonTitle = "Cancel"
        rootItem.interfaceFactory.actionButtonTitleColor = .white
        rootItem.isDismissable = true
        rootItem.interfaceFactory.tintColor = .mainBlue
        rootItem.actionHandler = { item in
            rootItem.displayNextItem()
        }
        rootItem.alternativeHandler = { item in
            rootItem.manager?.dismissBulletin(animated: true)
        }
        return rootItem
    }()
    
    
    lazy var bulletinManager: BulletinManager = {
        return BulletinManager(rootItem: self.rootItem)
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        tableView.register(DetailedNewsTableViewCell.self, forCellReuseIdentifier: DetailedNewsTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var reportButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Report an error", for: .normal)
        button.titleLabel?.font = .sfProTextMedium(ofSize: 15)
        button.backgroundColor = .mainBlue
        button.addTarget(self, action: #selector(reportPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    init(news: News) {
        super.init(nibName: nil, bundle: nil)
        self.newsObject = news
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationBar()
        setupConstraints()
    }
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .default
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    // MARK: - Inital Setup
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(newsImageView)
        view.addSubview(reportButton)
    }
    
    func setupNavigationBar() {
        title = "News"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.sfProTextSemibold(ofSize: 17)]
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        constrain(tableView, view, reportButton) { tableView, view, reportButton in
            tableView.top == view.top
            tableView.left == view.left
            tableView.right == view.right
            tableView.bottom == view.bottom - 49
            
            reportButton.top == tableView.bottom + 5
            reportButton.left == view.left
            reportButton.right == view.right
            reportButton.height == 44
        }
        
        tableView.parallaxHeader.view = newsImageView
        tableView.parallaxHeader.height = 240
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .topFill
    }
    
    // MARK: - Helper methods
    @objc func reportPressed() {
        bulletinManager.backgroundViewStyle = .dimmed
        bulletinManager.prepare()
        bulletinManager.presentBulletin(above: self)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedNewsTableViewCell", for: indexPath) as! DetailedNewsTableViewCell
        cell.titleLabel.text = newsObject?.title
        cell.dateLabel.text = newsObject?.date ?? "" + " /"
        cell.bodyLabel.text = newsObject?.description
        cell.shortLabel.text = newsObject?.shortInfo
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

