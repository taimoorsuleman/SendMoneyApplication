//
//  AppDelegate.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupLanguage()
        setupInitialViewController()
        return true
    }
    
    // MARK: - Private Methods
    /// Configures and sets the initial language for the application.
    private func setupLanguage() {
        let currentLanguage = LanguageManager.shared.currentLanguage.rawValue
        Bundle.setLanguage(currentLanguage)
    }
    
    /// Configures and sets the initial view controller for the application.
    private func setupInitialViewController() {
        let loginVC = LoginBuilder.build()  // Builds the Login module
        // Uncomment the following line to set the Dashboard as the initial screen.
        //        let dashboardVC = DashboardBuilder.build()
        
        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.hidesBarsWhenVerticallyCompact = true
        
        // Initialize the application window and set the root view controller.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
}
