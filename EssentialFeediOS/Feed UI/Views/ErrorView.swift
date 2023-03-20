//
//  ErrorView.swift
//  EssentialFeediOS
//
//  Created by Jason Ou on 2023/3/20.
//

import UIKit

public final class ErrorView: UIView {
    @IBOutlet private(set) public var button: UIButton!
    
    public var message: String? {
        get { return isVisible ? buttonTitle : nil }
        set { setMessageAnimated(newValue) }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonTitle = nil
        alpha = 0
    }
    
    private var buttonTitle: String? {
        get { button.titleLabel?.text }
        set { button.titleLabel?.text = newValue }
    }
    
    private var isVisible: Bool {
        return alpha > 0
    }
    
    private func setMessageAnimated(_ message: String?) {
        if let message = message {
            showAnimated(message)
        } else {
            hideMessageAnimated()
        }
    }
    
    private func showAnimated(_ message: String) {
        buttonTitle = message
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
    
    @IBAction private func hideMessageAnimated() {
        UIView.animate(
            withDuration: 0.25,
            animations: { self.alpha = 0 },
            completion: { completed in
                if completed { self.buttonTitle = nil }
            })
    }
}
