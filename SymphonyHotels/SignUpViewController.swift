//
//  SignUpViewController.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailNameTextField: UITextField!
    @IBOutlet weak var usernameNameTextField: UITextField!
    @IBOutlet weak var passwordNameTextField: UITextField!
    
    // MARK: Actions
    
    /// User signup
    @IBAction func signUpAction() {
        guard let fname = firstNameTextField.text, let lname = lastNameTextField.text, let email = emailNameTextField.text, let username = usernameNameTextField.text, let password = passwordNameTextField.text else {
            return
        }
        
        let parameters = [
            "first_name": fname,
            "last_name": lname,
            "email": email,
            "username": username,
            "password": password
        ]
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/register/", method: .post, parameters: parameters) {
            [weak self] (status, response) in
            if status == .created {
                self?.presentAlert("Success", message: "User created")
            } else {
                self?.presentAlert("Error", message: "Status code: \(status)")
            }
        }
    }
    
}
