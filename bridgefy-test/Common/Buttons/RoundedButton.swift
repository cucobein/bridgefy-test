//
//  RoundedButton.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet { setupButton() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
        for state in [
            UIControl.State.normal,
            UIControl.State.highlighted,
            UIControl.State.selected,
            UIControl.State.disabled
        ] {
            if let title = title(for: state) {
                self.setTitle(title, for: state)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = cornerRadius
        clipsToBounds = false
    }
}
