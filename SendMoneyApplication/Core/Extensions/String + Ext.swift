//
//  String.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 18/11/2024.
//

import Foundation

// MARK: - String Extension

/// An extension of the `String` class to provide additional functionalities such as localization and generating random alphanumeric strings.
extension String {
    
    // MARK: - Localization
    
    /// Returns a localized version of the string using `NSLocalizedString`.
    ///
    /// This computed property allows for easy localization of strings by accessing the `.localized` property.
    /// It fetches the corresponding localized string from the `Localizable.strings` file based on the current locale.
    ///
    /// **Usage Example:**
    /// ```swift
    /// let greeting = "welcome_message".localized
    /// ```
    ///
    /// - Returns: A localized string corresponding to the key.
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    // MARK: - Random Alphanumeric String Generation
    
    /// Generates a random alphanumeric string of the specified length.
    ///
    /// This static method creates a string composed of random characters from the defined `characters` set.
    /// It can be used for purposes such as generating unique identifiers, temporary passwords, or random tokens.
    ///
    /// **Usage Example:**
    /// ```swift
    /// let randomString = String.randomAlphanumeric(length: 12)
    /// print(randomString) // e.g., "A1b2C3d4E5f6"
    /// ```
    ///
    /// - Parameter length: The desired length of the generated string. Defaults to `10` if not specified.
    /// - Returns: A random alphanumeric string of the specified length.
    static func randomAlphanumeric(length: Int = 10) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
    
}
