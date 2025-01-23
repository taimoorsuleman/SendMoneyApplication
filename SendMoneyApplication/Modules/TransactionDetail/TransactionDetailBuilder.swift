//
//  TransactionDetailBuilder.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

// MARK: - TransactionDetailBuilder

/// Responsible for building and configuring the Transaction Detail screen.
enum TransactionDetailBuilder {
    
    /// Constructs the TransactionDetailViewController with necessary dependencies.
    ///
    /// - Parameter request: The transaction model containing necessary data.
    /// - Returns: A fully configured TransactionDetailViewController instance.
    static func build(_ request: TransactionModel) -> UIViewController {
        // Initialize ViewModel with the transaction request
        let viewModel = TransactionDetailViewModel(request: request)
        
        // Initialize Router for navigation
        let router = TransactionDetailRouter()
        
        // Load the storyboard with localization (if applicable)
        let storyboard = UIStoryboard(name: StoryboardID.sendMoney, bundle: nil)
        
        // Instantiate TransactionDetailViewController from storyboard
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: ViewControllerID.transactionDetail) as? TransactionDetailViewController else {
            fatalError("TransactionDetailViewController not found in storyboard.")
        }
        
        // Inject dependencies into the view controller
        detailVC.viewModel = viewModel
        detailVC.router = router
        
        return detailVC
    }
}
