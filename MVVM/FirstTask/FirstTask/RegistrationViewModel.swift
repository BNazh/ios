//
//  ViewModel.swift
//  FirstTask
//
//  Created by Nazhmeddin on 2019-02-07.
//  Copyright © 2019 Nazhmeddin. All rights reserved.
//

import Foundation
import UIKit

class RegistrationViewModel {
    
    var fullName: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false  && isBinding?.value != nil
        isFormValidObserver?(isFormValid)
    }
    
    var isFormValidObserver: ((Bool)->())?
    
    var isBinding: Binding<Any>!
}
