//
//  LanguageManager.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import Foundation
import UIKit

/// Enum representing supported application languages.
enum Language: String {
    case english = "en"
    case arabic = "ar"
    
    /// Default language for the application.
    static var defaultLanguage: Language {
        return .english
    }
}

/// Singleton class to manage language preferences and UI updates.
final class LanguageManager {
    
    // MARK: - Properties
    
    static let shared = LanguageManager()  // Shared instance for global access.
    
    private let userDefaultsKey = "appLanguage"  // Key to store language preference.
    private let appleLangKey = "AppleLanguages"  // Apple system language key.

    /// Returns the currently selected language.
    var currentLanguage: Language {
        if let savedLanguage = UserDefaults.standard.string(forKey: userDefaultsKey),
           let language = Language(rawValue: savedLanguage) {
            return language
        }
        return Language.defaultLanguage
    }
    
    // MARK: - Methods
    
    /// Sets the application language and updates UI accordingly.
    /// - Parameter language: The selected language.
    func setLanguage(_ language: Language) {
        guard currentLanguage != language else { return }
        
        UserDefaults.standard.set([language.rawValue], forKey: appleLangKey)
        UserDefaults.standard.set(language.rawValue, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
        
        // Update the language bundle dynamically
        Bundle.setLanguage(language.rawValue)
        
        // Adjust layout direction for the selected language
        updateLayoutDirection(for: language)
        
        // Reload the application to reflect language changes
        reloadApplication()
    }
    
    /// Updates UI layout direction based on the selected language.
    /// - Parameter language: The selected language.
    private func updateLayoutDirection(for language: Language) {
        let isRTL = (language == .arabic)
        
        // Set UI components' layout direction based on the language
        UIView.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        UITextField.appearance().textAlignment = isRTL ? .right : .left
        UITextView.appearance().textAlignment = isRTL ? .right : .left
        UILabel.appearance().textAlignment = isRTL ? .right : .left
        UIButton.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        UICollectionView.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        UINavigationBar.appearance().semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
        
        // Apply the updated layout direction to all app windows (iOS 15+ compatibility)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.forEach { window in
                window.semanticContentAttribute = isRTL ? .forceRightToLeft : .forceLeftToRight
            }
        }
    }
    
    /// Reloads the application with a smooth transition effect to reflect the language change.
    private func reloadApplication() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let window = appDelegate.window else { return }
        
        let dashboardVC = DashboardBuilder.build()
        let navVC = UINavigationController(rootViewController: dashboardVC)
        
        // Apply a crossfade animation for a smooth transition
        UIView.transition(with: window, duration: 1, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navVC
        }, completion: nil)
        
        window.makeKeyAndVisible()
    }
}
