//
//  BaseViewController.swift
//  news-app
//
//  Created by Babakhanov Nazhmeddin on 12/18/17.
//  Copyright © 2017 Nolan. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class BaseViewController: TwitterPagerTabStripViewController {
    
    // MARK: - Properties
    var isReload = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TwitterPagerTabStripViewController methods
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = NewsListViewController(itemInfo: IndicatorInfo(title: Constant.positiveNewsTitle), type: .positive)
        let child_2 = NewsListViewController(itemInfo: IndicatorInfo(title: Constant.negativeNewsTitle), type: .negative)
        
        guard isReload else {
            return [child_1, child_2]
        }
        
        var childViewControllers = [child_1, child_2]
        
        for index in childViewControllers.indices {
            let nElements = childViewControllers.count - index
            let n = (Int(arc4random()) % nElements) + index
            if n != index {
                childViewControllers.swapAt(index, n)
            }
        }
        let nItems = 1 + (arc4random() % 8)
        return Array(childViewControllers.prefix(Int(nItems)))
    }
}
