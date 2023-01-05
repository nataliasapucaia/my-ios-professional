//
//  ViewController.swift
//  TestUITextField
//
//  Created by Natália Sapucaia on 26/12/22.
//

import UIKit

class ViewController: UIViewController {
    let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray

        style()
        layout()
    }

    func style() {

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "enter your text here"
        textField.addTarget(self, action: #selector(printText), for: .editingChanged)
    }

    func layout() {
        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func printText() {
        print(textField.text)
    }
}

extension ViewController: UITextFieldDelegate {

}

