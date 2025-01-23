//
//  GlobalIdentifiers.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import Foundation

/// Identifiers for storyboards used in the application.
enum StoryboardID {
    static let main = String.mainStoryboardIdentifier
    static let authentication = String.authStoryboardIdentifier
    static let sendMoney = String.sendMoneyStoryboardIdentifier
}

/// Identifiers for view controllers used across the app.
enum ViewControllerID {
    static let login = String.loginVCIdentifier
    static let sendMoney = String.sendMoneyVCIdentifier
    static let dashboard = String.dashboardVCIdentifier
    static let transactionHistory = String.transactionHistoryVCIdentifier
    static let transactionDetail = String.transactionDetailVCIdentifier
}

/// Identifiers for table view cells.
enum CellID {
    static let transactionCell = String.transactionTableViewCell
}

// MARK: - String Extension for Constants
extension String {
    
    // Storyboard Identifiers
    static let mainStoryboardIdentifier = "Main"
    static let authStoryboardIdentifier = "Authentication"
    static let sendMoneyStoryboardIdentifier = "SendMoney"

    // ViewController Identifiers
    static let loginVCIdentifier = "LoginViewController"
    static let sendMoneyVCIdentifier = "SendMoneyViewController"
    static let dashboardVCIdentifier = "DashboardViewController"
    static let transactionHistoryVCIdentifier = "TransactionHistoryViewController"
    static let transactionDetailVCIdentifier = "TransactionDetailViewController"

    // TableView Cell Identifiers
    static let transactionTableViewCell = "TransactionHistoryTableViewCell"

    // General Strings
    static let emptyString = ""
}
