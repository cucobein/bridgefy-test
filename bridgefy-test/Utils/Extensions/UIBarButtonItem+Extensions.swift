//
//  UIBarButtonItem+Extensions.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 28/03/21.
//

import UIKit
import Bond

extension UIBarButtonItem {
    
    static func textBarButtonItem(title: String,
                                  color: UIColor = .bridgefyRed,
                                  tapHandler handler: @escaping () -> Void) -> UIBarButtonItem {
        let textAttributes = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.animosaRegularFont(withSize: 16)
        ]
        let item = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        item.setTitleTextAttributes(textAttributes, for: .normal)
        _ = item.reactive.tap.observeNext {
            handler()
        }
        return item
    }
}
