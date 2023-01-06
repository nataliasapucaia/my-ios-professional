//
//  PasswordTextField.swift
//  Password
//
//  Created by Natália Sapucaia on 29/11/22.
//

import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}

class PasswordTextField: UIView {

    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let dividerLine = UIView()
    let errorLabel = UILabel()

    /**
     A function one passes in to do custom validation on the text field.

     - Parameter: textValue: The value of text to validate
     - Returns: A Bool indicating whether text is valid, and if not a String containing an error message
     */
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

    let placeholderText: String
    var customValidation: CustomValidation? // add
    weak var delegate: PasswordTextFieldDelegate?

    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }

    init(placeholderText: String) {
        self.placeholderText = placeholderText
        super.init(frame: .zero)

        style()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }

    @objc
    private func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry = true
        eyeButton.isSelected.toggle()
    }

    @objc
    private func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }
}

extension PasswordTextField {

    func style() {
        translatesAutoresizingMaskIntoConstraints = false

        lockImageView.translatesAutoresizingMaskIntoConstraints = false

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false // true
        textField.placeholder = placeholderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged )

        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)

        dividerLine.translatesAutoresizingMaskIntoConstraints = false
        dividerLine.backgroundColor = .separator

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.font = .preferredFont(forTextStyle: .footnote)
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.text = "Your password must meet the requirements below"
        errorLabel.isHidden = true
    }

    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerLine)
        addSubview(errorLabel)

        NSLayoutConstraint.activate([
            lockImageView.topAnchor.constraint(equalTo: topAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),

            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),

            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),

            dividerLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerLine.heightAnchor.constraint(equalToConstant: 1),
            dividerLine.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),

            errorLabel.topAnchor.constraint(equalTo: dividerLine.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
    }
}

extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }

    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("foo - textFieldShouldReturn")
        textField.endEditing(true) // resign first responder
        return true
    }
}

// typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

// MARK: - Validation
extension PasswordTextField {
    func validate() -> Bool {
        if let customValidation = customValidation,
           let customValidationResult = customValidation(text),
           customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }

    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }

    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
