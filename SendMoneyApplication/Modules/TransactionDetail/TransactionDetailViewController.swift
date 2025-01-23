//
//  TransactionDetailViewController.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

/// Displays the details of a specific transaction.
final class TransactionDetailViewController: BaseViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var textView: UITextView!

    // MARK: - Dependencies
    
    var viewModel: TransactionDetailViewModelProtocol!
    var router: TransactionDetailRouterProtocol!
   
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Data Handling
    
    /// Loads transaction details and updates the UI.
    private func loadData() {
        self.navigationItem.title = viewModel.getTitle()
        viewModel.loadTransactionDetails()
        textView.text = viewModel.jsonString
    }
}
