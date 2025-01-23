//
//  DashboardRouter.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import UIKit

// MARK: - DashboardRouterProtocol

/// Defines the navigation responsibilities for the Dashboard module.
///
/// Handles navigation to screens such as Send Money and Transaction History.
protocol DashboardRouterProtocol {
    
    /// Navigates to the Send Money screen.
    /// - Parameter from: The current view controller initiating the navigation.
    func navigateToSendMoneyScreen(from vc: UIViewController)
    
    /// Navigates to the Transaction History screen.
    /// - Parameter from: The current view controller initiating the navigation.
    func navigateToTransactionHistoryScreen(from vc: UIViewController)
    
    /// Reloads the dashboard screen, resetting the navigation stack.
    func reloadScreen()
}

// MARK: - DashboardRouter

/// Handles screen navigation within the Dashboard module.
final class DashboardRouter: DashboardRouterProtocol {
    
    // MARK: - Properties
    
    /// Logger service instance for tracking navigation events.
    private let logger = LoggerService.shared
    
    // MARK: - Navigation Methods
    
    /// Navigates to the Send Money screen.
    /// - Parameter vc: The current view controller initiating the navigation.
    func navigateToSendMoneyScreen(from vc: UIViewController) {
        logger.logInfo("Navigating to Send Money screen.", category: "DashboardRouter")
        
        let sendMoneyVC = SendMoneyBuilder.build()
        
        guard let navigationController = vc.navigationController else {
            logger.logError("NavigationController not found. Cannot proceed.", category: "DashboardRouter")
            return
        }
        
        navigationController.pushViewController(sendMoneyVC, animated: true)
        logger.logInfo("Successfully navigated to Send Money screen.", category: "DashboardRouter")
    }
    
    /// Navigates to the Transaction History screen.
    /// - Parameter vc: The current view controller initiating the navigation.
    func navigateToTransactionHistoryScreen(from vc: UIViewController) {
        logger.logInfo("Navigating to Transaction History screen.", category: "DashboardRouter")
        
        let transactionHistoryVC = TransactionHistoryBuilder.build()
        
        guard let navigationController = vc.navigationController else {
            logger.logError("NavigationController not found. Cannot proceed.", category: "DashboardRouter")
            return
        }
        
        navigationController.pushViewController(transactionHistoryVC, animated: true)
        logger.logInfo("Successfully navigated to Transaction History screen.", category: "DashboardRouter")
    }
    
    /// Reloads the dashboard screen by resetting the app's root view controller.
    func reloadScreen() {
        logger.logInfo("Reloading Dashboard screen.", category: "DashboardRouter")
        
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            logger.logError("No active UIWindowScene found. Cannot reload Dashboard.", category: "DashboardRouter")
            return
        }
        
        guard let window = scene.windows.first else {
            logger.logError("No active window found. Cannot reload Dashboard.", category: "DashboardRouter")
            return
        }
        
        let dashboardVC = DashboardBuilder.build()
        let navigationController = UINavigationController(rootViewController: dashboardVC)
        
        // Reset the root view controller
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil) { _ in
            self.logger.logInfo("Successfully reloaded the Dashboard screen.", category: "DashboardRouter")
        }
    }
}
