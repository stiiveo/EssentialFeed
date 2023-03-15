//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/15.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return self.dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
