//
//  UINavigationBar + Ext.swift
//  TrendingArticles
//
//  Created by Taimoor Suleman on 19/10/2024.
//

import UIKit

// MARK: - UINavigationBar Extension

extension UINavigationBar {
    
    /// Configures a custom appearance for the navigation bar with specified background and title colors.
    ///
    /// - Parameters:
    ///   - backgroundColor: The desired background color of the navigation bar.
    ///   - titleColor: The desired color of the navigation bar's title text.
    func setCustomAppearance(backgroundColor: UIColor, titleColor: UIColor) {
        // Set the background color of the navigation bar
        barTintColor = backgroundColor
        
        // Set the tint color for bar button items
        tintColor = titleColor
        
        // Define the title text attributes, including color and font
        self.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
    }
    
    /// Applies a standardized appearance to the navigation bar using `UINavigationBarAppearance`.
    ///
    /// This method sets up a consistent look for the navigation bar across the app, including background color,
    /// title text attributes, and back button appearance.
    func setNavigationBarAppearance() {
        // Initialize a new appearance instance
        let appearance = UINavigationBarAppearance()
        
        // Configure the appearance to use an opaque background
        appearance.configureWithOpaqueBackground()
        
        // Set the background color using a predefined color (ensure `.appPrimary` is defined in your UIColor extensions)
        appearance.backgroundColor = .appPrimary
        
        // Set the title text attributes, specifically the text color
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        // Set a custom back button image with automatic RTL support
//        if let backImage = UIImage(named: "icon_next")?.imageFlippedForRightToLeftLayoutDirection(){
//            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
//        }
//            
        // Remove the back button text by making it transparent
        appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
        
        // Set the tint color of the navigation bar to white (affects bar button items)
        tintColor = .white
        
        // Apply the configured appearance to the navigation bar
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}

// MARK: - UINavigationController Extension

extension UINavigationController {
    
    /// Navigates back to a specific view controller within the navigation stack.
    ///
    /// - Parameter vc: The target view controller to navigate back to. Must be an instance of the desired view controller type.
    func backToViewController(vc: Any) {
        // Iterate through the view controllers in the navigation stack
        for element in viewControllers {
            // Compare the type of the current element with the type of the target view controller
            if "\(type(of: element))" == "\(type(of: vc))" {
                // If a match is found, pop to that view controller
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}
