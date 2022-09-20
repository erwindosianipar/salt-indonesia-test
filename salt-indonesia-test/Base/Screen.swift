//
//  Screen.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

internal protocol Screenable: AnyObject {
    
    var identifier: String { get }
    var event: ((Navigation) -> Void)? { get set }
    
    func build() -> ViewController
}

internal class Screen<T>: Screenable {
    
    var identifier: String {
        return ""
    }
    
    var event: ((Navigation) -> Void)?
    
    var input: T
    
    init(_ input: T) {
        self.input = input
    }
    
    func build() -> ViewController {
        return ViewController()
    }
}
