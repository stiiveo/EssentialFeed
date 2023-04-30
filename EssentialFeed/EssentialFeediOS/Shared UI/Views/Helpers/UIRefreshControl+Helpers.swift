//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/20.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
