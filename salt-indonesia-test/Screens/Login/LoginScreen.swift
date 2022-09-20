//
//  LoginScreen.swift
//  salt-indonesia-test
//
//  Created by Erwindo Sianipar on 20/09/22.
//

let kLoginScreen = "Login Screen"

internal final class LoginScreen: Screen<Void> {
    
    override var identifier: String {
        return kLoginScreen
    }
    
    override func build() -> ViewController {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
