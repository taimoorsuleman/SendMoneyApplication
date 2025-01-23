//
//  TransactionHistoryViewModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import Combine

protocol TransactionHistoryViewModelProtocol {
    var transactionsPublisher: Published<[TransactionModel]>.Publisher { get }
    var transactions: [TransactionModel] { get }
    func fetchTransactionHistory()
    func getTitle() -> String
}

/// Manages business logic for the Transaction History screen.
final class TransactionHistoryViewModel: TransactionHistoryViewModelProtocol {
    
    @Published private(set) var transactions: [TransactionModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    var transactionsPublisher: Published<[TransactionModel]>.Publisher { $transactions }
    private let logger = LoggerService.shared
    
    init() {
        bindToAppState()
        logger.logInfo("TransactionHistoryViewModel initialized.", category: "TransactionHistoryViewModel")
    }
    
    private func bindToAppState() {
        AppState.shared.$requests
            .sink { [weak self] requests in
                self?.transactions = requests
                self?.logger.logInfo("Transactions updated with \(requests.count) records.", category: "TransactionHistoryViewModel")
            }
            .store(in: &cancellables)
    }
    
    func fetchTransactionHistory() {
        logger.logInfo("Fetching transaction history.", category: "TransactionHistoryViewModel")
        AppState.shared.loadRequests()
    }
    
    func getTitle() -> String {
        return "Saved Requests".localized
    }
    
    deinit {
        logger.logInfo("TransactionHistoryViewModel deinitialized.", category: "TransactionHistoryViewModel")
    }
}
