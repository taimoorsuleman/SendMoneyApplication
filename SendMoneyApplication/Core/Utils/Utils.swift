//
//  Utils.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 22/01/2025.
//

import Foundation

/// Utility structure containing helper functions for common tasks.
struct Utils {
    
    /// Generates a random alphanumeric string of the specified length.
    ///
    /// - Parameter length: The desired length of the generated string. Default value is 10.
    /// - Returns: A randomly generated alphanumeric string.
    static func randomAlphanumeric(length: Int = 10) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        // Create a random string using characters from the provided set
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
}
