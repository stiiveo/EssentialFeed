//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Jason Ou on 2023/3/11.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(.touchUpInside)
    }
}

