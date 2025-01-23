//
//  TransactionDetailRouter.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

protocol TransactionDetailRouterProtocol {
    func navigateToDetailScreen(_ request: TransactionModel, from vc: UIViewController)
}

final class TransactionDetailRouter: TransactionDetailRouterProtocol {
    
    private let logger = LoggerService.shared
    
    func navigateToDetailScreen(_ request: TransactionModel, from vc: UIViewController) {
        logger.logInfo("Navigating to Transaction Detail screen.", category: "TransactionDetailRouter")
        
        let detailVC = TransactionDetailBuilder.build(request)
        
        guard let navigationController = vc.navigationController else {
            logger.logError("NavigationController not found. Cannot navigate.", category: "TransactionDetailRouter")
            return
        }
        
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    deinit {
        logger.logInfo("TransactionDetailRouter deinitialized.", category: "TransactionDetailRouter")
    }
}
