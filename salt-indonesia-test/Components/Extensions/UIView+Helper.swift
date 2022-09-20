//
//  UIView+Helper.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
