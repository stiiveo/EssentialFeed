//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Jason Ou on 2023/3/11.
//

import UIKit

extension UIControl {
    func simulate(_ event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach { action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
}
