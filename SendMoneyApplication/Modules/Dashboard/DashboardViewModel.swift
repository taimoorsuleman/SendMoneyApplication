//
//  DashboardViewModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation

// MARK: - DashboardViewModelProtocol

/// Defines the responsibilities of the Dashboard ViewModel.
protocol DashboardViewModelProtocol {
    func getTitle() -> String
    func changeLanguage(language: Language)
}

// MARK: - DashboardViewModel

/// Handles business logic for the Dashboard screen.
final class DashboardViewModel: DashboardViewModelProtocol {
    
    // MARK: - Properties
    
    private let logger = LoggerService.shared
    
    // MARK: - Initialization
    
    init() {
        logger.logInfo("DashboardViewModel initialized.", category: "DashboardViewModel")
    }
        
    func getTitle() -> String {
        return "dashboard_title".localized
    }
    
    func changeLanguage(language: Language) {
        LanguageManager.shared.setLanguage(language)
    }
    
    // MARK: - Cleanup
    
    deinit {
        logger.logInfo("DashboardViewModel deinitialized.", category: "DashboardViewModel")
    }
}
