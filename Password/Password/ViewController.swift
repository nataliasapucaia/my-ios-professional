//
//  ViewController.swift
//  Password
//
//  Created by Natália Sapucaia on 29/11/22.
//

import UIKit

class ViewController: UIViewController {


    let stackView = UIStackView()
    let newPasswordTextField = PasswordTextField(placeholderText: "New password")
    let passwordCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
        // Do any additional setup after loading the view.
    }


}

extension ViewController {

    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
    }

    func layout() {
        stackView.addArrangedSubview(newPasswordTextField)
        stackView.addArrangedSubview(passwordCriteriaView)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
