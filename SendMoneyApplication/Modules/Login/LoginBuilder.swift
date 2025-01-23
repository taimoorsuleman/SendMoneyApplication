//
//  LoginBuilder.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import Foundation
import UIKit

// MARK: - LoginBuilder

/// Responsible for assembling the Login module with its dependencies.
enum LoginBuilder {
    
    /// Builds and returns an instance of `LoginViewController` with dependencies.
    static func build() -> LoginViewController {
        
        // Initialize dependencies
        let viewModel: LoginViewModelProtocol = LoginViewModel()
        let router: LoginRouterProtocol = LoginRouter()
        
        // Load storyboard and instantiate view controller
        let storyboard = UIStoryboard(name: StoryboardID.authentication, bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: ViewControllerID.login) as? LoginViewController else {
            fatalError("LoginViewController not found in \(StoryboardID.authentication) storyboard.")
        }
        
        // Inject dependencies
        loginVC.viewModel = viewModel
        loginVC.router = router
        
        return loginVC
    }
}
