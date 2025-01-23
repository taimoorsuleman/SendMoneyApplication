//
//  DashboardViewController.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 21/01/2025.
//

import UIKit

// MARK: - DashboardViewController

/// A view controller that manages the Dashboard screen, allowing users to navigate
/// to Send Money and Transaction History features.
final class DashboardViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var transactionHistoryBtn: UIButton!
    @IBOutlet weak var sendMoneyBtn: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: - Dependencies
    
    var viewModel: DashboardViewModelProtocol!
    var router: DashboardRouterProtocol!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureInitialLanguage()
    }
    
    // MARK: - UI Setup
    
    fileprivate func setupUI() {
        // Example: apply custom navigation bar appearance
        navigationController?.navigationBar.setNavigationBarAppearance()
        
        // Set localized title from the view model
        navigationItem.title = viewModel.getTitle().localized
        
        // Set localized text for buttons
        sendMoneyBtn.setTitle("send_money_button".localized, for: .normal)
        transactionHistoryBtn.setTitle("transaction_history_button".localized, for: .normal)
        
    }
    
    // MARK: - Language Configuration
    
    /// Syncs the segmented control with the current language code (e.g., "en"/"ar").
    private func configureInitialLanguage() {
        let currentLangCode = LanguageManager.shared.currentLanguage.rawValue
        segmentControl.selectedSegmentIndex = (currentLangCode == "en") ? 0 : 1
    }
    
    /// Change language after confirmation
    private func changeLanguage(to language: Language) {
        viewModel.changeLanguage(language: language)
    }
    
    /// Reset the segment control if language change is canceled
    private func resetLanguageSegment() {
        let currentLangCode = LanguageManager.shared.currentLanguage.rawValue
        segmentControl.selectedSegmentIndex = (currentLangCode == "en") ? 0 : 1
    }
    
    /// Show confirmation alert before changing the language
    private func showLanguageChangeConfirmation(for language: Language) {
        let alertTitle = "language_change_confirmation_title".localized
        let alertMessage = "language_change_confirmation_message".localized
        let confirmTitle = "yes_button_title".localized
        let cancelTitle = "cancel_button_title".localized
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: confirmTitle, style: .default) { [weak self] _ in
            guard let self = self else { return }
            LoggerService.shared.logInfo("User confirmed language change to \(language.rawValue).")
            self.changeLanguage(to: language)
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            LoggerService.shared.logInfo("User cancelled language change.")
            resetLanguageSegment()
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Segment Control Action
    
    /// Called when the user changes the selected segment in the language segmented control.
    ///
    /// - Parameter sender: The segmented control instance.
    @IBAction func languageChanged(_ sender: UISegmentedControl) {
        // Switch language based on selected segment
        let selectedLanguage: Language = (sender.selectedSegmentIndex == 0) ? .english : .arabic
        showLanguageChangeConfirmation(for: selectedLanguage)
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func sendMoneyBtnTapped(_ sender: UIButton) {
        router.navigateToSendMoneyScreen(from: self)
    }
    
    @IBAction func transactionHistoryBtnTapped(_ sender: UIButton) {
        router.navigateToTransactionHistoryScreen(from: self)
    }
}
