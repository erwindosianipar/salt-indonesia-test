//
//  HomeScreen.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 19/09/22.
//

let kHomeScreen = "Home Screen"

internal final class HomeScreen: Screen<HomeScreenResult> {
    
    override var identifier: String {
        return kHomeScreen
    }
    
    override func build() -> ViewController {
        let viewModel = HomeViewModel(screenResult: input)
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
