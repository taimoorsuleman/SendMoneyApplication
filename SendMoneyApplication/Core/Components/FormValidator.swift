//
//  FormValidator.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation

// MARK: - Protocol for validating form fields

/// A protocol that defines the validation rules for form fields.
protocol FormValidatorProtocol {
    /// Validates the given input field based on specific rules.
    /// - Parameter inputField: A `GenericField` object containing field data.
    /// - Returns: `true` if the field value is valid, otherwise `false`.
    func validateField(inputField: GenericField) -> Bool
}

// MARK: - Concrete implementation of FormValidatorProtocol

/// A concrete implementation of `FormValidatorProtocol` to handle field validation logic.
final class FormValidator: FormValidatorProtocol {
    
    /// Validates a given input field based on its text content, length, and regex pattern.
    /// - Parameter inputField: A `GenericField` object to validate.
    /// - Returns: `true` if the input meets validation criteria, otherwise `false`.
    func validateField(inputField: GenericField) -> Bool {
        // Trim whitespace from input and ensure it's not empty
        guard let text = inputField.textField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty else {
            // Validation failed: text is empty
            return false
        }
        
        // Validate maximum input length if defined
        if let maxLen = inputField.maxInputLength, maxLen > 0, text.count > maxLen {
            // Validation failed: text exceeds maximum length
            return false
        }
        
        // Validate input against regex pattern if provided
        if let pattern = inputField.validationRegex, !pattern.isEmpty {
            let regex = try? NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: text.utf16.count)
            if regex?.firstMatch(in: text, options: [], range: range) == nil {
                // Validation failed: text does not match regex pattern
                return false
            }
        }
        
        // Input is valid
        return true
    }
}
