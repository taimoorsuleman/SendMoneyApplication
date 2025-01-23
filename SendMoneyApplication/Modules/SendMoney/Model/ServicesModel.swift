//
//  ServicesModel.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//
import Foundation

// MARK: - ServicesResponse

struct ServicesResponse: Codable {
    let title: TranslationObj
    let services: [ServiceModel]
}

// MARK: - ServiceModel

struct ServiceModel: Codable {
    let label: TranslationObj
    let name: String?
    let providers: [ProviderModel]
}

// MARK: - TranslationObj

struct TranslationObj: Codable {
    let en, ar: String?
    
    /// Computed property to return the value based on the selected language.
    var localized: String? {
        let isRTL = LanguageManager.shared.currentLanguage == .arabic
       
        if isRTL {
            return ar ?? en // Fallback to English if Arabic is missing
        }
        return en ?? ar // Fallback to Arabic if English is missing
            
    }
    
}
