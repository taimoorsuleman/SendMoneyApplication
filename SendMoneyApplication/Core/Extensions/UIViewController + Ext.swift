//
//  UIViewController + Ext.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 18/11/2024.
//

import UIKit

// MARK: - UIViewController Extension

extension UIViewController {
    
    // MARK: - Activity Indicator Methods
    
    /// Starts an activity indicator at the center of the view.
    ///
    /// This method creates and displays a `UIActivityIndicatorView` with the specified style and color.
    /// It ensures that the activity indicator runs on the main thread.
    ///
    /// - Parameters:
    ///   - style: The style of the activity indicator. Defaults to `.large`.
    ///   - color: The color of the activity indicator. Defaults to `.secondaryLabel`.
    func startActivityIndicator(style: UIActivityIndicatorView.Style = .large, color: UIColor? = .secondaryLabel) {
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.center = self.view.center
            activityIndicator.color = color
            
            // Add a unique tag to identify the activity indicator
            activityIndicator.tag = 100
            activityIndicator.hidesWhenStopped = true
            self.view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
    }
    
    /// Stops and removes the activity indicator from the view.
    ///
    /// This method searches for a `UIActivityIndicatorView` with the predefined tag and stops its animation.
    /// It ensures that the operation runs on the main thread.
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.viewWithTag(100) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Keyboard Handling
    
    /// Enables tap gesture recognition to dismiss the keyboard when tapping outside input fields.
    ///
    /// This method adds a `UITapGestureRecognizer` to the view, allowing users to tap anywhere
    /// outside of input fields to dismiss the keyboard.
    func enableTapToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    /// Dismisses the keyboard.
    ///
    /// This method is called when the tap gesture recognizer detects a tap.
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Alert Methods
    
    /// Presents an alert with a title, message, and an optional action.
    ///
    /// This method creates and displays a `UIAlertController` with the provided title and message.
    /// It includes an "OK" button, which can execute an optional closure when tapped.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message body of the alert.
    ///   - buttonTitle: The title for the action button. Defaults to a localized "OK".
    ///   - okAction: An optional closure to execute when the action button is tapped.
    func showAlert(title: String, message: String, buttonTitle: String = "ok_button_title".localized, okAction: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: buttonTitle, style: .default) { _ in
            okAction?()  // Execute the closure when OK is tapped
        }
        
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    
    /// Shows a confirmation alert with a Yes/No option.
        ///
        /// - Parameters:
        ///   - title: The title of the alert.
        ///   - message: The message displayed in the alert.
        ///   - confirmTitle: The title for the confirmation action.
        ///   - cancelTitle: The title for the cancellation action.
        ///   - confirmHandler: Closure executed if the user confirms the action.
        func showConfirmationAlert(
            title: String,
            message: String,
            confirmTitle: String = "yes_button_title".localized,
            cancelTitle: String = "cancel_button_title".localized,
            confirmHandler: @escaping () -> Void
        ) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { _ in
                confirmHandler()
            }
            
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
}
