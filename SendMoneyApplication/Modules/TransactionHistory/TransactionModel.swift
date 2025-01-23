//
//  TransactionModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import Foundation

struct TransactionModel: Codable {
    let id: String
    let serviceName: String
    let providerName: String
    let formData: [String: String]
}
