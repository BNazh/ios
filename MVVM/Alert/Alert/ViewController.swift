//
//  ViewController.swift
//  Alert
//
//  Created by Nazhmeddin on 2019-02-19.
//  Copyright © 2019 Nazhmeddin. All rights reserved.
//

import UIKit
import Cartography

class ViewController: UIViewController {

    var alertBasic: BasicActionSheet!
    var imagePicker:ImagePicker!
    
    let alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alert", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(handleClick), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    @objc func handleClick(){
        alertBasic.present()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(alertButton)
        
        constrain(alertButton){  alertButton in
            alertButton.center == alertButton.superview!.center
            alertButton.width == 200
            alertButton.height == 100
        }
        addAlert()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imagePicker = ImagePicker.init(presentationController: self, delegate: self, mediaTypes: [.image, .video])
    }
    
    func addAlert(){
        let camera = BasicAlertAction.init(title: "Камера", style: .default) { [weak self] in
            // Hello
            
        }
        
        let library = BasicAlertAction.init(title: "Фото или видео", style: .default) { [weak self] in
            // Hello
        }
        
        alertBasic = BasicActionSheet.init(presentationViewController: self, title: nil, message: nil, actions: [ camera, library], cancelActionEnabled: true)
        alertBasic.tintColor = .black

    }
    
    
    


}




extension UIAlertAction {
    static var propertyNames: [String] {
        var outCount: UInt32 = 0
        guard let ivars = class_copyIvarList(self, &outCount) else {
            return []
        }
        var result = [String]()
        let count = Int(outCount)
        for i in 0..<count {
            let pro: Ivar = ivars[i]
            guard let ivarName = ivar_getName(pro) else {
                continue
            }
            guard let name = String(utf8String: ivarName) else {
                continue
            }
            result.append(name)
        }
        return result
    }
}

