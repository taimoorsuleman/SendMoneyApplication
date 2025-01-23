//
//  ProviderModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation

// MARK: - ProviderModel

/// Represents a service provider with its associated details and required fields for transactions.
struct ProviderModel: Codable {
    let name, id: String?
    
    let requiredFields: [FieldModel]

    enum CodingKeys: String, CodingKey {
        case name, id
        case requiredFields = "required_fields"
    }
}
