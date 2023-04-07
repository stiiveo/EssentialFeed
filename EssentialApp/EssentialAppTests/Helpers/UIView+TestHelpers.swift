//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Jason Ou on 2023/4/7.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
