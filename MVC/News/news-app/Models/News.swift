//
//  News.swift
//  news-app
//
//  Created by Beknar Danabek on 12/18/17.
//  Copyright © 2017 Nolan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper

struct News: Mappable {
    
    var title: String?
    var description: String?
    var shortInfo: String?
    var date: String?
    var link: String?
    
    init?(map: Map) {
        
    }
    
    init(title: String?, description: String?, shortInfo: String?, date: String?, link: String?) {
        self.title = title
        self.description = description
        self.shortInfo = shortInfo
        self.date = date
        self.link = link
    }
    
    mutating func mapping(map: Map) {
        title            <- map["title"]
        date             <- map["date"]
        description      <- map["description"]
        link             <- map["link"]
        shortInfo        <- map["short_info"]
    }

    static func fetch(of type: NewsType, onSuccess: @escaping ([News])  -> Void, onFailure: @escaping (String)  -> Void) {
        // MARK: Local JSON File + SwiftyJSON
        var news = [News]()
        if let path = Bundle.main.path(forResource: "\(type == .positive ? LocalPath.positive : LocalPath.negative)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let list: Array<JSON> = try JSON(data: data).arrayValue
                for item in list {
                    news.append(News(title: item["title"].string,
                                     description: item["description"].string,
                                     shortInfo: item["short_info"].string,
                                     date: item["date"].string,
                                     link: item["link"].string))
                }
                onSuccess(news)
            } catch {
                onFailure(Constant.errorMessage)
            }
        }
        // MARK: Alamofire + ObjectMapper
//        Alamofire.request(urlPaths.root + (type == .positive ? urlPaths.positive : urlPaths.negative)).responseJSON { response in
//            guard let json = response.result.value,
//                let news = Mapper<News>().mapArray(JSONObject: json) else {
//                    onFailure(Constants.errorMessage)
//                    return
//            }
//            onSuccess(news)
//        }
    }
    
}
