//
//  TransactionHistoryViewController.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit
import Combine

/// Displays a list of transaction histories.
final class TransactionHistoryViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Dependencies
    var viewModel: TransactionHistoryViewModelProtocol!
    var router: TransactionHistoryRouterProtocol!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchTransactionHistory()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        self.navigationItem.title = viewModel.getTitle()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - ViewModel Binding
    
    private func bindViewModel() {
        viewModel = TransactionHistoryViewModel()
        
        viewModel.transactionsPublisher
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TransactionHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.transactions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellID.transactionCell, for: indexPath) as? TransactionHistoryTableViewCell else {
            return UITableViewCell()
        }
        
        let transaction = viewModel.transactions[indexPath.row]
        cell.configure(with: transaction)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        let transaction = viewModel.transactions[indexPath.row]
        router.navigateToDetailScreen(transaction, from: self)
    }
}
