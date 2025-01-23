
//
//  LoggerService.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation
import os

/// A centralized logging utility to be used across the entire application.
final class LoggerService {
    
    /// Shared instance to be used across the app for logging
    static let shared = LoggerService()

    /// OSLog instance for logging messages with a given subsystem and category.
    private let logger: Logger

    /// Private initializer to enforce singleton pattern.
    private init(subsystem: String = Bundle.main.bundleIdentifier ?? "com.company.SendMoneyApplication", category: String = "General") {
        self.logger = Logger(subsystem: subsystem, category: category)
    }
    
    /// Logs an informational message.
    /// - Parameters:
    ///   - message: The log message.
    ///   - category: Optional category for better filtering in logs.
    func logInfo(_ message: String, category: String = "General") {
        logger.info("\(category): \(message)")
    }
    
    /// Logs an error message.
    /// - Parameters:
    ///   - message: The error message.
    ///   - category: Optional category for better filtering in logs.
    func logError(_ message: String, category: String = "General") {
        logger.error("\(category): \(message)")
    }
    
    /// Logs a debug message (only shown in debug builds).
    /// - Parameters:
    ///   - message: The debug message.
    ///   - category: Optional category for better filtering in logs.
    func logDebug(_ message: String, category: String = "General") {
        #if DEBUG
        logger.debug("\(category): \(message)")
        #endif
    }
    
    /// Logs a warning message.
    /// - Parameters:
    ///   - message: The warning message.
    ///   - category: Optional category for better filtering in logs.
    func logWarning(_ message: String, category: String = "General") {
        logger.warning("\(category): \(message)")
    }
}
