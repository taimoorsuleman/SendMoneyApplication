import UIKit

final class SendMoneyViewController: BaseViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Dependencies
    var viewModel: SendMoneyViewModelProtocol!
    var router: SendMoneyRouterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()  // Register for keyboard appearance notifications
        
        // Observe ViewModel data changes and update UI accordingly
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            self.updateUI()
        }
        
        // Load initial form data from ViewModel
        viewModel.loadFormData()
    }
    
    // MARK: - Private Methods
    
    /// Sets the navigation bar title based on the current language
    private func setTitle() {
        if let screenTitle = viewModel.screenTitle {
            navigationItem.title = screenTitle.localized
        }
    }
    
    /// Updates the UI dynamically based on the selected service and provider
    private func updateUI() {
        setTitle()
        
        // Remove all existing views in the stack view before adding new ones
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // Add service selection field
        let serviceField = GenericField()
        serviceField.headerText = "select_service".localized
        serviceField.placeholderText = "select_service".localized
        serviceField.isDropdown = true
        serviceField.dropdownOptions = viewModel.services.map { $0.label.localized ?? .emptyString }
        serviceField.textField.text = viewModel.selectedService?.label.localized ?? .emptyString
        
        // Handle service selection change
        serviceField.onValueChange = { [weak self] selectedService in
            self?.viewModel.updateSelectedService(selectedService)
            self?.updateUI()  // Refresh UI when service changes
        }
        stackView.addArrangedSubview(serviceField)
        
        // Add provider selection field if a service is selected
        if let selectedService = viewModel.selectedService {
            let providerField = GenericField()
            providerField.headerText = "select_provider".localized
            providerField.placeholderText = "select_provider".localized
            providerField.isDropdown = true
            providerField.dropdownOptions = selectedService.providers.map { $0.name ?? .emptyString }
            providerField.textField.text = viewModel.selectedProvider?.name ?? .emptyString
            
            // Handle provider selection change
            providerField.onValueChange = { [weak self] selectedProvider in
                self?.viewModel.updateSelectedProvider(selectedProvider)
                self?.updateUI()  // Refresh UI when provider changes
            }
            stackView.addArrangedSubview(providerField)
        }
        
        // Add dynamically generated required fields based on selected provider
        if let selectedProvider = viewModel.selectedProvider {
            for field in selectedProvider.requiredFields {
                let genericField = GenericField()
                genericField.headerText = field.label?.localized
                genericField.placeholderText = field.placeholder
                genericField.fieldType = field.type
                genericField.isDropdown = field.type == .option
                genericField.dropdownOptions = field.type == .option ? (field.options?.map { $0.label ?? .emptyString } ?? []) : []
                genericField.validationRegex = field.validation
                genericField.maxInputLength = field.maxLength
                genericField.validationErrorMessage = field.validationErrorMessage
                genericField.fieldName = field.name
                
                // Add the generic field to the stack view
                stackView.addArrangedSubview(genericField)
            }
            
            // Add Send Button at the bottom of the form
            let sendButton = createSendButton()
            
            // Container view to center the button within the stack view
            let buttonContainer = UIView()
            buttonContainer.addSubview(sendButton)
            stackView.addArrangedSubview(buttonContainer)
            
            // Apply constraints to center the button and set its width to 50% of the stack view
            NSLayoutConstraint.activate([
                sendButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
                sendButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
                sendButton.heightAnchor.constraint(equalToConstant: 44),
                buttonContainer.widthAnchor.constraint(equalTo: stackView.widthAnchor)
            ])
        }
    }
    
    /// Creates the send button programmatically
    private func createSendButton() -> UIButton {
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send".localized, for: .normal)
        sendButton.addTarget(self, action: #selector(sendForm), for: .touchUpInside)
        sendButton.tag = 999  // Unique tag to identify the send button
        sendButton.backgroundColor = .systemBlue
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.cornerRadius = 8
        sendButton.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
        return sendButton
    }
    
    /// Handles the form submission
    @objc private func sendForm() {
        let inputFields = gatherInputFields()
        let isValid = viewModel.validateForm(inputs: inputFields)
        
        if isValid {
            print("Form submitted successfully!")
            saveRequest()
        } else {
            print("Please fill all required fields correctly.")
        }
    }
    
    /// Gathers user input fields from the stack view
    private func gatherInputFields() -> [GenericField] {
        var inputs: [GenericField] = []
        
        // Iterate over stackView subviews and collect GenericField instances
        for case let field as GenericField in stackView.arrangedSubviews {
            inputs.append(field)
        }
        return inputs
    }
    
    /// Generates request data based on user input and selected service/provider
    private func generateRequestData() -> TransactionModel {
        let inputFields = gatherInputFields()
        var items = [String: String]()
        
        // Collect input data from fields (excluding service and provider fields)
        for field in inputFields.dropFirst(2) {
            items[field.fieldName ?? .emptyString] = field.textField.text
        }
        
        let request = TransactionModel(
            id: Utils.randomAlphanumeric(),
            serviceName: viewModel.selectedService?.label.localized ?? .emptyString,
            providerName: viewModel.selectedProvider?.name ?? .emptyString,
            formData: items
        )
        return request
    }
    
    /// Saves the submitted request to local app state and navigates back
    private func saveRequest() {
        let newRequest = generateRequestData()
        AppState.shared.addRequest(newRequest)
        
        self.showAlert(title: "success_title".localized, message: "money_sent_message".localized) { [weak self] in
            guard let self = self else { return }
            self.router.navigateToPreviousScreen(from: self)
        }
    }
}

// MARK: - Keyboard Handling
extension SendMoneyViewController {
    /// Registers keyboard show/hide notifications to adjust scroll view
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    /// Adjusts scroll view insets when the keyboard appears
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom
            scrollView.contentInset.bottom = bottomInset
            scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
        }
    }
    
    /// Resets scroll view insets when the keyboard hides
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
}
