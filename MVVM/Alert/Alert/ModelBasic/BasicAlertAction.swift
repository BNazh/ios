//
//  BasicAlertAction.swift
//  Alert
//
//  Created by Mac on 2019-02-19.
//  Copyright © 2019 Nazhmeddin Babakhanov. All rights reserved.
//

import UIKit

struct BasicAlertAction {
    var title: String
    var style: UIAlertAction.Style
    var handler: () -> ()
}
