//
//  Binding.swift
//  FirstTask
//
//  Created by Nazhmeddin on 2019-02-12.
//  Copyright © 2019 Nazhmeddin. All rights reserved.
//

import Foundation

class Binding<T> {
    init(_ v: T) {
        value = v
    }
    var value: T {
        didSet {
            print(value)
        }
    }
}
