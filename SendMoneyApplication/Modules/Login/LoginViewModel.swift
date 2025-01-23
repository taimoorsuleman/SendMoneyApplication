//
//  LoginViewModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import Foundation

// MARK: - LoginViewModelProtocol

/// Handles login operations.
protocol LoginViewModelProtocol {
    var email: String { get set }
    var password: String { get set }
    var errorMessage: String? { get }
    func login(completion: @escaping (Bool) -> Void)
}

// MARK: - LoginViewModel

/// ViewModel for managing login logic.
final class LoginViewModel: LoginViewModelProtocol {
    
    var email: String = .emptyString
    var password: String = .emptyString
    private(set) var errorMessage: String?
    
    private let logger = LoggerService.shared
    
    init() {
        logger.logInfo("LoginViewModel initialized.", category: "LoginViewModel")
    }
    
    func login(completion: @escaping (Bool) -> Void) {
        logger.logInfo("Login attempt started.", category: "LoginViewModel")
        
        let loginModel = LoginModel(email: email, password: password)
        let (isValid, validationError) = loginModel.validate()
        
        if isValid {
            logger.logInfo("Validation succeeded.", category: "LoginViewModel")
            
            if loginModel.email.lowercased() == "testuser" && loginModel.password == "password123" {
                self.errorMessage = nil
                completion(true)
            } else {
                logger.logWarning("Authentication failed.", category: "LoginViewModel")
                self.errorMessage = "user_not_found".localized
                completion(false)
            }
            
        } else {
            logger.logWarning("Validation failed.", category: "LoginViewModel")
            self.errorMessage = validationError
            completion(false)
        }
    }
    
    deinit {
        logger.logInfo("LoginViewModel deinitialized.", category: "LoginViewModel")
    }
}
