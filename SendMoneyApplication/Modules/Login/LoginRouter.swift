//
//  LoginRouter.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 18/01/2025.
//

import UIKit

// MARK: - LoginRouterProtocol

/// Defines navigation responsibilities for the Login module.
protocol LoginRouterProtocol {
    func navigateToDashboardScreen()
}

// MARK: - LoginRouter

/// Handles navigation logic from the Login module to other screens.
final class LoginRouter: LoginRouterProtocol {
    
    /// Logger instance for tracking navigation events.
    private let logger = LoggerService.shared
    
    /// Navigates to the Dashboard screen with a smooth transition effect.
    func navigateToDashboardScreen() {
    }
}
