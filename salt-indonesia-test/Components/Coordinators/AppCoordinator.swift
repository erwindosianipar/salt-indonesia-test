//
//  AppCoordinator.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

import UIKit

internal final class AppCoordinator {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if UserDefaultConfig.email.isEmpty {
            let loginCoordinator = LoginCoordinator(window: window)
            loginCoordinator.start()
        } else {
            let homeCoordinator = HomeCoordinator(window: window)
            homeCoordinator.start()
        }
    }
}
