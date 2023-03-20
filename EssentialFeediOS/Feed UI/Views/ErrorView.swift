//
//  ErrorView.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/20.
//

import UIKit

public final class ErrorView: UIView {
    @IBOutlet private var label: UILabel!
    
    public var message: String? {
        get { label.text }
        set { label.text = newValue }
    }
}
