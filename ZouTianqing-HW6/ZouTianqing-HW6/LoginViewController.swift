//
//  LoginViewController.swift
//  ZouTianqing-HW6
//
//  Created by 阿清 on 3/29/26.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmField.isHidden = true
        confirmLabel.isHidden = true
        statusLabel.isHidden = true
        statusLabel.text = ""
    }
    

    @IBAction func segmentChanged(_ sender: Any) {
        // Only show the status label when there is an error.
        statusLabel.isHidden = true
        statusLabel.text = ""

        if (sender as AnyObject).selectedSegmentIndex == 0 {
            confirmField.isHidden = true
            confirmLabel.isHidden = true
            actionButton.setTitle("Sign In", for: .normal)
        } else {
            confirmLabel.isHidden = false
            confirmField.isHidden = false
            actionButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    
    @IBAction func actionButtonTapped(_ sender: Any) {

        if segmentedCtrl.selectedSegmentIndex == 0 {
            // Sign In & create a new user
            let email = idField.text ?? ""
            let password = passwordField.text ?? ""
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.statusLabel.isHidden = false
                    self.statusLabel.text = "Error: \(error.localizedDescription)"
                } else {
                    self.statusLabel.text = ""
                    self.statusLabel.isHidden = true
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                        self.idField.text = ""
                        self.passwordField.text = ""
                    }
                }
            }
        } else {
            // Sign Up
            guard let confirmPassword = confirmField.text, !confirmPassword.isEmpty else {
                statusLabel.isHidden = false
                statusLabel.text = "Please confirm your password."
                return
            }
            
            guard let password = passwordField.text, password == confirmPassword else {
                statusLabel.isHidden = false
                statusLabel.text = "Passwords do not match."
                return
            }

            guard let email = idField.text, !email.isEmpty else {
                statusLabel.isHidden = false
                statusLabel.text = "Please enter your email."
                return
            }

            if password.isEmpty {
                statusLabel.isHidden = false
                statusLabel.text = "Please enter your password."
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.statusLabel.isHidden = false
                    self.statusLabel.text = "Error: \(error.localizedDescription)"
                } else {
                    self.statusLabel.text = ""
                    self.statusLabel.isHidden = true

                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "loginSegue", sender: self)
                        self.idField.text = ""
                        self.passwordField.text = ""
                        self.confirmField.text = ""
                    }
                }
            }
        }
    }
}
