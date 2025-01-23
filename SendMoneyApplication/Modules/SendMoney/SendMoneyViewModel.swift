//
//  SendMoneyViewModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import Foundation

// MARK: - SendMoneyViewModelProtocol

protocol SendMoneyViewModelProtocol {
    var onDataUpdated: (() -> Void)? { get set }
    var services: [ServiceModel] { get }
    var screenTitle: TranslationObj? { get }
    var selectedService: ServiceModel? { get }
    var selectedProvider: ProviderModel? { get }
    
    func loadFormData()
    func updateSelectedService(_ serviceName: String)
    func updateSelectedProvider(_ providerName: String)
    func validateForm(inputs: [GenericField]) -> Bool
}

// MARK: - SendMoneyViewModel

/// Handles the business logic for the Send Money screen.
final class SendMoneyViewModel: SendMoneyViewModelProtocol {
    
    // MARK: - Dependencies
    
    private let dataService: SendMoneyDataServiceProtocol
    private let validator: FormValidatorProtocol
    private let logger = LoggerService.shared
    
    // MARK: - Properties
    
    var onDataUpdated: (() -> Void)?
    private(set) var services: [ServiceModel] = []
    private(set) var screenTitle: TranslationObj?
    private(set) var selectedService: ServiceModel?
    private(set) var selectedProvider: ProviderModel?
    
    // MARK: - Initialization
    
    init(dataService: SendMoneyDataServiceProtocol, validator: FormValidatorProtocol) {
        self.dataService = dataService
        self.validator = validator
    }
    
    // MARK: - Data Loading
    
    func loadFormData() {
        do {
            let response = try dataService.fetchServices()
            screenTitle = response.title
            services = response.services
            logger.logInfo("Form data loaded successfully.", category: "SendMoneyViewModel")
            onDataUpdated?()
        } catch DataServiceError.fileNotFound {
            logger.logError("Service data file not found.", category: "SendMoneyViewModel")
        } catch DataServiceError.decodingError(let errorMessage) {
            logger.logError("Failed to decode service data: \(errorMessage)", category: "SendMoneyViewModel")
        } catch {
            logger.logError("Unexpected error loading form data: \(error.localizedDescription)", category: "SendMoneyViewModel")
        }
    }
    
    // MARK: - Selection Handlers
    
    func updateSelectedService(_ serviceName: String) {
        selectedService = services.first { $0.label.en == serviceName }
        selectedProvider = nil
        
        if selectedService != nil {
            logger.logInfo("Selected service updated to: \(serviceName)", category: "SendMoneyViewModel")
        } else {
            logger.logWarning("Selected service not found: \(serviceName)", category: "SendMoneyViewModel")
        }
        
        onDataUpdated?()
    }
    
    func updateSelectedProvider(_ providerName: String) {
        guard let service = selectedService else {
            logger.logWarning("Attempted to select a provider without a selected service.", category: "SendMoneyViewModel")
            return
        }
        
        selectedProvider = service.providers.first { $0.name == providerName }
        
        if selectedProvider != nil {
            logger.logInfo("Selected provider updated to: \(providerName)", category: "SendMoneyViewModel")
        } else {
            logger.logWarning("Selected provider not found: \(providerName)", category: "SendMoneyViewModel")
        }
        
        onDataUpdated?()
    }
    
    // MARK: - Validation
    
    func validateForm(inputs: [GenericField]) -> Bool {
        var isFormValid = true
        
        for fieldInput in inputs {
            if !validator.validateField(inputField: fieldInput) {
                fieldInput.showError("Validation failed for field:".localized + "\(fieldInput.headerText?.localized ?? "Unknown")")
                logger.logError("Validation failed for field: \(fieldInput.headerText ?? "Unknown")", category: "SendMoneyViewModel")
                isFormValid = false
            } else {
                fieldInput.hideError()
            }
        }
        
        if isFormValid {
            logger.logInfo("Form validation successful.", category: "SendMoneyViewModel")
        } else {
            logger.logError("Form validation failed.", category: "SendMoneyViewModel")
        }
        
        return isFormValid
    }
}
