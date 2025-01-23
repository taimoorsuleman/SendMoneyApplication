//
//  TransactionDetailViewModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import Foundation

// MARK: - TransactionDetailViewModelProtocol

/// Handles transaction detail-related operations.
protocol TransactionDetailViewModelProtocol {
    var jsonString: String { get }
    func loadTransactionDetails()
    func getTitle() -> String
}

// MARK: - TransactionDetailViewModel

/// Manages business logic for the Transaction Detail screen.
final class TransactionDetailViewModel: TransactionDetailViewModelProtocol {
    
    private let request: TransactionModel
    private(set) var jsonString: String = "{}"
    private let logger = LoggerService.shared
    
    init(request: TransactionModel) {
        self.request = request
    }
    
    func getTitle() -> String {
        return "Transaction Details".localized
    }

    func loadTransactionDetails() {
        do {
            let jsonData = try JSONEncoder().encode(request)
            if let prettyJson = formatPrettyJSON(from: jsonData) {
                jsonString = prettyJson
                logger.logInfo("Transaction details loaded successfully.", category: "TransactionDetailViewModel")
            } else {
                jsonString = "{}"
                logger.logWarning("Failed to format JSON.", category: "TransactionDetailViewModel")
            }
        } catch {
            jsonString = "{}"
            logger.logError("Failed to encode JSON: \(error.localizedDescription)", category: "TransactionDetailViewModel")
        }
    }
    
    private func formatPrettyJSON(from data: Data) -> String? {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8)
        } catch {
            logger.logError("Error formatting JSON: \(error.localizedDescription)", category: "TransactionDetailViewModel")
            return nil
        }
    }
}
