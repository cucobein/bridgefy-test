//
//  UITextField+Helpers.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit

extension UITextField {
    
    func underlined(color: UIColor, alpha: CGFloat = 1.0) {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = color.withAlphaComponent(alpha).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
