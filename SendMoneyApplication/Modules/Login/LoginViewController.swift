//
//  LoginViewController.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 17/01/2025.
//

import UIKit

/// Handles user interactions and login functionality for the login screen.
final class LoginViewController: BaseViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var privacyLbl: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Dependencies
    
    var viewModel: LoginViewModelProtocol!
    var router: LoginRouterProtocol!

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    /// Configures the UI elements with localized text and default properties.
    private func setupUI() {
        titleLbl.text = "signin_title_lbl".localized
        subTitleLbl.text = "signin_sub_title_lbl".localized
        emailField.placeholder = "signin_email_placeholder".localized
        passwordField.placeholder = "signin_password_placeholder".localized
        signInBtn.setTitle("signin_signin_btn".localized, for: .normal)
        privacyLbl.text = "signin_terms_text".localized
        
        signInBtn.isEnabled = true
        
        // Add target actions for text field changes
        emailField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
    }
    
    // MARK: - Text Field Handlers
    
    /// Updates the email property in ViewModel when the text field changes.
    @objc private func emailTextFieldChanged(_ textField: UITextField) {
        viewModel.email = textField.text ?? .emptyString
    }
    
    /// Updates the password property in ViewModel when the text field changes.
    @objc private func passwordTextFieldChanged(_ textField: UITextField) {
        viewModel.password = textField.text ?? .emptyString
    }
    
    // MARK: - Actions
    
    /// Initiates the login process when the sign-in button is tapped.
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        viewModel.login { [weak self] success in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if success {
                    self.errorLabel.isHidden = true
                    self.router.navigateToDashboardScreen()
                } else {
                    self.errorLabel.text = self.viewModel.errorMessage
                    self.errorLabel.isHidden = false
                }
            }
        }
    }
}
