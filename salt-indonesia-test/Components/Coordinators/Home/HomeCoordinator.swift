//
//  HomeCoordinator.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

import UIKit

internal final class HomeCoordinator: NavigationCoordinator {
    
    let window: UIWindow
    
    var navigationController: UINavigationController = UINavigationController()
    
    var screenStack: [Screenable] = []
    
    var onCompleted: ((ScreenResult?) -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let screens = [
            HomeScreen((HomeScreenResult(email: UserDefaultConfig.email)))
        ]
        
        set(screens)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showScreen(identifier: String, navigation: Navigation) {
        switch identifier {
        case kHomeScreen:
            setHomeScreenNavigation(navigation: navigation)
        default:
            break
        }
    }
    
    private func setHomeScreenNavigation(navigation: Navigation) {
        switch navigation {
        case .next, .prev:
            return
        }
    }
}
