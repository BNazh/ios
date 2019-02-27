//
//  Constants.swift
//  news-app
//
//  Created by  Nazhmeddin Babakhanov  on 27/03/2018.
//  Copyright © 2018 Nolan. All rights reserved.
//

import Foundation

enum Constant {
    static let positiveNewsTitle = "Positive News"
    static let negativeNewsTitle = "Negaitve News"
    static let errorMessage = "Please, try again later"
    static let errorTitleText = "Error"
    static let alertOkText = "Ok"
}

enum UrlPath {
    static let root = "https://babahan-1999.000webhostapp.com/"
    static let positive = "pos.json"
    static let negative = "neg.json"
}

enum LocalPath {
    case positive
    case negative
}
