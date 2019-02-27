//
//  ViewController.swift
//  WeatherData
//
//  Created by Babakhan Nazhmeddin on 15.03.2018.
//  Copyright © 2018 Babakhan Nazhmeddin. All rights reserved.
//

import UIKit
import Cartography
import Alamofire
import SwiftyJSON

protocol TableDataProtocol {
    var weathers: [WeatherModel] {get set}
}

class ViewController: UIViewController, TableDataProtocol {
    
    var getData: WeatherModel?
    
    var weathers: [WeatherModel] = []
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "wall"))
        return image
    }()

    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "What's the weather?"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your city"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    lazy var cityName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter city Name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 7
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = UIColor(red: 108/255, green: 193/255, blue: 117/255, alpha: 1)
        button.layer.cornerRadius = 7
        button.addTarget(self, action: #selector(showInfoWeather), for: .touchUpInside)
        return button
    }()
    
    lazy var historyButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: self, action: #selector(openHistoryVC))
        return button
    }()
    
    lazy var dataView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: 18)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = historyButton
        
        view.addSubViews([backgroundImage, mainLabel, subLabel, cityName, submitButton, dataView])
        
        addConstraints()
    }
    
    private func addConstraints() {
        
        constrain(view, backgroundImage){ v1, v2 in
            v2.width == v1.width
            v2.height == v1.height
            v2.center == v1.center
        }
        
        constrain(view, mainLabel, subLabel){ v1, v2, v3 in
            v2.width == v1.width
            v2.centerX == v1.centerX
            v2.top == v1.top + view.bounds.height/8
            
            v3.width == v1.width * 0.5
            v3.centerX == v1.centerX
            v3.top == v2.bottom + 20
        }
        
        constrain(subLabel, cityName){ v1, v2 in
            v2.width == (v2.superview?.width)! * 0.8
            v2.height == 40
            v2.centerX == v1.centerX
            v2.top == v1.bottom + 30
        }
        
        constrain(cityName, submitButton, dataView){ v1, v2, v3 in
            v2.width == v1.width / 2
            v2.height == 30
            v2.centerX == v1.centerX
            v2.top == v1.bottom + 15
            
            v3.width == (v3.superview?.width)! * 0.8
            v3.height == 20
            v3.height == (v3.superview?.height)! * 0.3
            v3.centerX == v2.centerX
            v3.top == v2.bottom + 20
        }
    
    }
    
    @objc private func openHistoryVC() {
        let controller = HistoryViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func showInfoWeather() {
        getData = WeatherModel(cityName.text!, completion: {
            self.setDescriptions()
        })
    }
    
    private func setDescriptions() {
        
        if (!(getData?.readyData)!) {
            let alertController = UIAlertController(title: "Error", message: "Fiil the correct name", preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else{
            dataView.text = "Temperature: \(getData!.temp)\nHumidity: \(getData!.humidity)\nWind speed: \(getData!.windSpeed)\nSunrise Time: \(getData!.sunriseTime)\nSunset Time: \(getData!.sunsetTime)"
            
            weathers.append(getData!)
        }
    }
    
    
}

