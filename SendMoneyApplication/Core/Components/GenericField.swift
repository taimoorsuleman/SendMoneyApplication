//
//  GenericField.swift
//  SendMoneyApplication
//
//  Created by Taimoor Suleman on 20/01/2025.
//

import UIKit

/// A reusable UI component that provides various input field functionalities, including text and dropdown options.
class GenericField: UIView {
    
    // MARK: - Properties (For Validations)
    
    var validationRegex: String?
    var maxInputLength: Int?
    var validationErrorMessage: String?
    var fieldName: String?
    var onValueChange: ((String) -> Void)?
    var tapGestureHandler: (() -> Void)?
    
    // MARK: - Configurations
    
    var headerText: String? {
        didSet { headerLabel.text = headerText }
    }
    
    var placeholderText: String? {
        didSet { textField.placeholder = placeholderText }
    }
    
    var dropdownOptions: [String] = [] {
        didSet { pickerView.reloadAllComponents() }
    }
    
    var fieldType: FieldType? {
        didSet { textField.keyboardType = mapKeyboardType(for: fieldType) }
    }
    
    var isDropdown: Bool = false {
        didSet {
            dropdownButton.isHidden = !isDropdown
            textField.inputView = isDropdown ? pickerView : nil
            textField.tintColor = isDropdown ? .clear : .systemBlue  // Hide cursor for dropdowns
        }
    }
    
    // MARK: - UI Components
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 5.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = LanguageManager.shared.currentLanguage.rawValue == "en" ? .left : .right
        return tf
    }()
    
    private let dropdownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.isHidden = true
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .red
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pickerView = UIPickerView()
    
    private lazy var toolbar: UIToolbar = {
        let bar = UIToolbar()
        bar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "done_button_title".localized, style: .plain, target: self, action: #selector(dismissInputView))
        bar.setItems([doneButton], animated: false)
        return bar
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(didTapField))
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        addSubview(headerLabel)
        addSubview(containerView)
        containerView.addSubview(textField)
        containerView.addSubview(dropdownButton)
        addSubview(errorLabel)
        
        textField.delegate = self
        textField.inputAccessoryView = toolbar
        pickerView.delegate = self
        pickerView.dataSource = self
        
        containerView.addGestureRecognizer(tapGesture)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Set the height of the entire GenericField view
            self.heightAnchor.constraint(equalToConstant: 80),
            
            // Header Label Constraints
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            // Container View Constraints
            containerView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            // TextField Constraints
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: dropdownButton.leadingAnchor, constant: -8),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            // Dropdown Button Constraints
            dropdownButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            dropdownButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dropdownButton.widthAnchor.constraint(equalToConstant: 20),
            dropdownButton.heightAnchor.constraint(equalToConstant: 20),
            
            // Error Label Constraints
            errorLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    // MARK: - Actions
    
    /// Handles the tap action on the field.
    @objc private func didTapField() {
        if isDropdown {
            textField.becomeFirstResponder()
        }
        tapGestureHandler?()
    }
    
    /// Dismisses the input view and updates the field value.
    @objc private func dismissInputView() {
        if isDropdown {
            let selectedRow = pickerView.selectedRow(inComponent: 0)
            let selectedValue = dropdownOptions[selectedRow]
            textField.text = selectedValue
            onValueChange?(selectedValue)
        }
        textField.resignFirstResponder()
    }
    
    /// Validates the input value based on configured rules.
    /// - Returns: `true` if the input is valid, otherwise `false`.
    @objc func validateInput() -> Bool {
        let requiredMessage = String(format: "field_required_message".localized, headerText ?? "Field")
        let invalidMessage = "invalid_input_message".localized

        // Check if the text field is not empty
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            showError(validationErrorMessage?.localized ?? requiredMessage)
            return false
        }
        
        // Check for maximum input length if defined
        if let maxLen = maxInputLength, maxLen > 0, text.count > maxLen {
            showError(validationErrorMessage?.localized ?? String(format: "field_max_length_message".localized, "\(maxLen)"))
            return false
        }
        
        // Validate against regex pattern if provided
        if let regex = validationRegex, !regex.isEmpty {
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            if !predicate.evaluate(with: text) {
                showError(validationErrorMessage?.localized ?? invalidMessage)
                return false
            }
        }
        
        hideError()
        return true
    }
    
    /// Displays an error message below the input field.
    /// - Parameter message: The error message to display.
    func showError(_ message: String) {
        errorLabel.isHidden = false
        errorLabel.text = message
    }
    
    /// Hides the error message.
    func hideError() {
        errorLabel.isHidden = true
    }
    
    /// Maps the field type to the corresponding keyboard type.
    /// - Parameter type: The `FieldType` of the input field.
    /// - Returns: A `UIKeyboardType` based on the field type.
    private func mapKeyboardType(for type: FieldType?) -> UIKeyboardType {
        switch type {
        case .msisdn:
            return .phonePad
        case .number:
            return .decimalPad
        case .text:
            return .default
        default:
            return .default
        }
    }
}

// MARK: - UITextField Delegate
extension GenericField: UITextFieldDelegate {
    
    /// Called when the text field ends editing.
    /// - Parameter textField: The text field that ended editing.
    func textFieldDidEndEditing(_ textField: UITextField) {
        _ = validateInput()
    }
}

// MARK: - UIPickerView Delegate & DataSource
extension GenericField: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dropdownOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dropdownOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = dropdownOptions[row]
        textField.text = selectedValue
        onValueChange?(selectedValue)
    }
}
