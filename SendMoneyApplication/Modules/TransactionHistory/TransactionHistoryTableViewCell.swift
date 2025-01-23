//
//  TransactionHistoryTableViewCell.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import UIKit

/// Custom table view cell to display transaction details.
final class TransactionHistoryTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var servicesLbl: UILabel!
    @IBOutlet weak var providerLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Configuration
    
    /// Populates the cell with transaction data.
    func configure(with transaction: TransactionModel) {
        idLbl.text = transaction.id
        servicesLbl.text = transaction.serviceName
        providerLbl.text = transaction.providerName
        
        if let amount = transaction.formData["amount"] {
            amountLbl.text = "AED \(amount)"
        } else {
            amountLbl.text = "AED 0.00"
        }
    }
}
