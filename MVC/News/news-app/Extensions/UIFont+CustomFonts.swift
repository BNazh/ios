//
//  UIFont+CustomFonts.swift
//  news-app
//
//  Created by  Nazhmeddin Babakhanov  on 27/03/2018.
//  Copyright © 2018 Nolan. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func sfProTextMedium(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SFProText-Medium", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }

    
    static func sfProTextSemibold(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SFProText-Semibold", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextRegular(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SFProText-Regular", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
    static func sfProTextLight(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "SFProText-Light", size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    
}
