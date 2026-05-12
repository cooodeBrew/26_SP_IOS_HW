//
//  ViewController.swift
//  ZouTianqing-HW2
//
//  Created by 阿清 on 2/3/26.
//  Project: ZouTianqing-HW2
//  EID: tz4654
//  Course: CS371L
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardDismiss()
    }

    // MARK: - Private Helpers

    /// Adds a tap gesture so touching outside the keyboard dismisses it.
    private func setupKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Actions

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let userID = userIDTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !userID.isEmpty,
              !password.isEmpty else {
            statusLabel.text = "Invalid login"
            return
        }
        statusLabel.text = "\(userID) logged in"
    }
}
