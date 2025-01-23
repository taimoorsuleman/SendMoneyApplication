//
//  SendMoneyBuilder.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 18/01/2025.
//

import Foundation
import UIKit

/// Assembles the Send Money module and injects dependencies.
enum SendMoneyBuilder {
    
    /// Creates and returns a configured `SendMoneyViewController` instance.
    static func build() -> UIViewController {
        
        // Initialize dependencies
        let dataService = SendMoneyDataService()
        let validator = FormValidator()
        let viewModel = SendMoneyViewModel(dataService: dataService, validator: validator)
        let router = SendMoneyRouter()
        
        // Load storyboard and instantiate the view controller
        let storyboard = UIStoryboard(name: StoryboardID.sendMoney, bundle: nil)
        guard let sendMoneyVC = storyboard.instantiateViewController(withIdentifier: ViewControllerID.sendMoney) as? SendMoneyViewController else {
            fatalError("SendMoneyViewController not found in \(StoryboardID.sendMoney) storyboard.")
        }
        
        // Inject dependencies
        sendMoneyVC.viewModel = viewModel
        sendMoneyVC.router = router
        
        return sendMoneyVC
    }
}
