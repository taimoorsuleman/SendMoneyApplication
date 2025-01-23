//
//  TransactionHistoryRouter.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

protocol TransactionHistoryRouterProtocol {
    /// Navigates to the transaction detail screen.
    func navigateToDetailScreen(_ request: TransactionModel, from vc: UIViewController)
}

/// Handles navigation within the Transaction History module.
final class TransactionHistoryRouter: TransactionHistoryRouterProtocol {
    
    func navigateToDetailScreen(_ request: TransactionModel, from vc: UIViewController) {
        let detailVC = TransactionDetailBuilder.build(request)
        vc.navigationController?.pushViewController(detailVC, animated: true)
    }
}
