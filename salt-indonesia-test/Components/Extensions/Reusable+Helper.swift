//
//  Reusable+Helper.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 13/02/22.
//

import UIKit

public protocol Reusable: AnyObject {
    
    static var identifier: String { get }
}

public extension Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
