//
//  HistoryViewController.swift
//  WeatherData
//
//  Created by Babakhan Nazhmeddin on 15.03.2018.
//  Copyright © 2018 Babakhan Nazhmeddin. All rights reserved.
//

import UIKit
import Cartography

class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var delegate: TableDataProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        button.layer.cornerRadius = 7
        button.backgroundColor = .cyan
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubViews([tableView, dismissButton])
        
        addConstraints()
        
    }
    
    private func addConstraints() {
        
        constrain(view, tableView, dismissButton){ v1, v2, v3 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
            
            v3.width == v1.width / 3
            v3.height == 40
            v3.bottom == v1.bottom - 30
            v3.centerX == v1.centerX
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (delegate?.weathers.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let weather = delegate?.weathers[indexPath.row]
        let todaysDate:NSDate = (weather?.currentData)!
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.string(from: todaysDate as Date)
        
        cell.textLabel?.text = (weather?.cityName)! + " | \(DateInFormat)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.weathers.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @objc private func dismissController() {
        navigationController?.popViewController(animated: true)
    }
    
}

