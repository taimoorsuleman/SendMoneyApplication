//
//  TransactionHistoryBuilder.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

/// Constructs the Transaction History screen with its dependencies.
enum TransactionHistoryBuilder {
    
    /// Creates and returns a configured `TransactionHistoryViewController` instance.
    static func build() -> UIViewController {
        let viewModel = TransactionHistoryViewModel()
        let router = TransactionHistoryRouter()
        
        let storyboard = UIStoryboard(name: .sendMoneyStoryboardIdentifier, bundle: nil)
        guard let transactionHistoryVC = storyboard.instantiateViewController(identifier: ViewControllerID.transactionHistory)
            as? TransactionHistoryViewController else {
            fatalError("TransactionHistoryViewController not found in storyboard.")
        }
        
        transactionHistoryVC.viewModel = viewModel
        transactionHistoryVC.router = router
        
        return transactionHistoryVC
    }
}
