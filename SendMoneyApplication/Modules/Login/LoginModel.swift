//
//  LoginModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import Foundation

// MARK: - LoginModel

/// A model representing the user's login credentials and validation logic.
///
/// This struct encapsulates the email and password entered by the user and provides
/// methods to validate these credentials according to defined rules.
struct LoginModel {
    
    // MARK: - Properties
    
    /// The user's email address.
    var email: String = .emptyString
    
    /// The user's password.
    var password: String = .emptyString
    
    // MARK: - Validation Methods
    
    /// Validates the user's email address.
    ///
    /// This method uses a regular expression to ensure that the email address follows
    /// a standard email format.
    ///
    /// - Returns: `true` if the email is valid, otherwise `false`.
    func isValidEmail() -> Bool {
        // Regular expression pattern for validating email addresses
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // Predicate to evaluate the email string against the regex pattern
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    /// Validates the user's username (email in this context).
    ///
    /// This method checks if the email has a minimum number of characters.
    /// Additional custom validation rules can be added as needed.
    ///
    /// - Returns: `true` if the username is valid, otherwise `false`.
    func isValidUserName() -> Bool {
        // Ensure the email has at least 3 characters
        return email.count >= 3
    }
    
    /// Validates the user's password.
    ///
    /// This method ensures that the password meets a minimum length requirement.
    /// Additional custom validation rules (e.g., complexity requirements) can be added as needed.
    ///
    /// - Returns: `true` if the password is valid, otherwise `false`.
    func isValidPassword() -> Bool {
        // Ensure the password has at least 6 characters
        return password.count >= 6
    }
    
    /// Validates the user's login credentials.
    ///
    /// This method performs a series of validations on the email and password.
    /// It returns a tuple indicating whether the credentials are valid and an associated message.
    ///
    /// - Returns: A tuple containing a `Bool` indicating validity and a `String` message.
    func validate() -> (isValid: Bool, message: String) {
        
        // Validate username (email)
        if !isValidUserName() {
            return (false, "invalid_username".localized)
        }
        
        // Validate password
        if !isValidPassword() {
            return (false, "invalid_password".localized)
        }
        
        // All validations passed
        return (true, .emptyString)
    }
}
