//
//  FieldModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation

// MARK: - FieldModel

/// Represents a form field with various properties and validation rules.
struct FieldModel: Codable {
    let label: TranslationObj?
    let name: String?
    let placeholder: String?
    let type: FieldType?
    let validation: String?
    let maxLength: Int?
    let validationErrorMessage: String?
    let options: [Option]?
    
    /// Provides the appropriate error message based on the validation result.
    /// Defaults to "This field is required" if no custom message is provided.
    var effectiveErrorMessage: String {
        return validationErrorMessage?.isEmpty == false ? validationErrorMessage! : "This field is required"
    }
    
    enum CodingKeys: String, CodingKey {
        case label, name, placeholder, type, validation
        case maxLength = "max_length"
        case validationErrorMessage = "validation_error_message"
        case options
    }
}

// MARK: - Option

struct Option: Codable {
    let label, name: String?
}

// MARK: - FieldType

/// Defines the type of input expected for a form field.
enum FieldType: String, Codable {
    case msisdn = "msisdn"
    case number = "number"
    case option = "option"
    case text = "text"
}
