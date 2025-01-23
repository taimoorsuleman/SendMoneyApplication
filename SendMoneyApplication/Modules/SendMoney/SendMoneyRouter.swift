//
//  SendMoneyRouter.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 18/01/2025.
//

import UIKit

// MARK: - SendMoneyRouterProtocol

protocol SendMoneyRouterProtocol {
    func navigateToPreviousScreen(from vc: UIViewController)
}

// MARK: - SendMoneyRouter

/// Handles navigation within the Send Money module.
final class SendMoneyRouter: SendMoneyRouterProtocol {
    
    private let logger = LoggerService.shared
    
    func navigateToPreviousScreen(from vc: UIViewController) {
        logger.logInfo("Navigating back to the previous screen.", category: "SendMoneyRouter")
        
        guard let navigationController = vc.navigationController else {
            logger.logError("NavigationController not found.", category: "SendMoneyRouter")
            return
        }
        
        navigationController.popViewController(animated: true)
        logger.logInfo("Successfully navigated back.", category: "SendMoneyRouter")
    }
    
    deinit {
        logger.logInfo("SendMoneyRouter deinitialized.", category: "SendMoneyRouter")
    }
}
