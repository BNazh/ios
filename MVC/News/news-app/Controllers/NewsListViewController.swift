//
//  ChildViewController.swift
//  news-app
//
//  Created by  Nazhmeddin Babakhanov  on 12/18/17.
//  Copyright © 2017 Nolan. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Cartography
import NVActivityIndicatorView
import TableFlip

enum NewsType {
    case positive
    case negative
}

class NewsListViewController: UIViewController {
    
    // MARK: - Properties
    var itemInfo: IndicatorInfo = ""
    var type: NewsType?
    
    var news = [News]() {
        didSet {
            tableView.reloadData()
        }
    }
    lazy var activityIndicator: NVActivityIndicatorView = {
        let activityIndicator = NVActivityIndicatorView(frame: CGRect.zero, type: NVActivityIndicatorType.pacman, color: .mainBlue)
        return activityIndicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.rowHeight = 100
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Initializers
    init(itemInfo: IndicatorInfo, type: NewsType) {
        super.init(nibName: nil, bundle: nil)
        self.itemInfo = itemInfo
        self.type = type
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        setupViews()
        setupNavigationBar()
        setupConstraints()
        fetchNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBar()
        animateTableView()
    }
    
    // MARK: - Inital Setup
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }
    
    func setupNavigationBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.barTintColor = .mainBlue
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        constrain(tableView, view) {tableView, view in
            tableView.top == view.top
            tableView.left == view.left
            tableView.right == view.right
            tableView.bottom == view.bottom - 60
        }
        
        constrain(activityIndicator, view) { activityIndicator, view in
            activityIndicator.width == 40
            activityIndicator.height == 40
            activityIndicator.center == view.center
        }
    }
    
    // MARK: - Data fetching
    @objc func fetchNews() {
  
        News.fetch(of: self.type ?? .negative, onSuccess: { [weak self] news in
            DispatchQueue.main.async {
                self?.news = news
                self?.animateActivitiyIndicator(false)
                self?.animateTableView()
            }
        }) { [weak self] error in
            self?.animateActivitiyIndicator(false)
            self?.createAlert(with: error)
        }
        

    }
    
    // MARK: - Helper methods
    func animateActivitiyIndicator(_ animate: Bool) {
        animate ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func animateTableView() {
        tableView.animate(animation: TableViewAnimation.Cell.fade(duration: 0.5))
    }
    
    func createAlert(with message: String) {
        let alert = UIAlertController(title: Constant.errorTitleText, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constant.alertOkText, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - IndicatorInfoProvider
extension NewsListViewController: IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news.count == 0 {
            tableView.backgroundView = activityIndicator
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            animateActivitiyIndicator(true)
        }
        return news.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.titleLabel.text = news[indexPath.row].title
        cell.dateLabel.text = news[indexPath.row].date
        let link = news[indexPath.row].link
        cell.newsImageView.kf.setImage(with: URL(string: link ?? ""), placeholder: UIImage(named: "bnews"), options: nil, progressBlock: nil, completionHandler: nil)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = DetailedNewsViewController(news: news[indexPath.row])
        if let cell = tableView.cellForRow(at: indexPath) as? NewsTableViewCell,
           let image = cell.newsImageView.image {
            viewController.newsImageView.image = image
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
