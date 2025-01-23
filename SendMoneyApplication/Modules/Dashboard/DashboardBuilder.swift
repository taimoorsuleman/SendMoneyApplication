//
//  DashboardBuilder.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import UIKit

// MARK: - DashboardBuilder

/// Responsible for assembling the Dashboard module and injecting dependencies.
enum DashboardBuilder {
    
    /// Builds and returns an instance of `DashboardViewController` with dependencies.
    static func build() -> DashboardViewController {
        
        // Initialize required dependencies
        let viewModel = DashboardViewModel()
        let router = DashboardRouter()
        
        let storyboard = UIStoryboard(name: StoryboardID.sendMoney, bundle: nil)
        
        guard let dashboardVC = storyboard.instantiateViewController(withIdentifier: ViewControllerID.dashboard) as? DashboardViewController else {
            fatalError("DashboardViewController not found in \(StoryboardID.sendMoney) storyboard.")
        }
        
        // Inject dependencies
        dashboardVC.viewModel = viewModel
        dashboardVC.router = router
        
        return dashboardVC
    }
}
