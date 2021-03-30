//
//  ClearanceHeaderView.swift
//  bridgefy-test
//
//  Created by Hugo Jovan Ramírez Cerón on 29/03/21.
//

import UIKit

final class ClearanceHeaderView: UIView {
    
    func set(title: String) {
        backgroundColor = .lightGray
        let label = UILabel(frame: CGRect(x: 24, y: 16, width: 150, height: 24))
        label.font = UIFont.animosaBoldFont(withSize: 18)
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
    }
}
