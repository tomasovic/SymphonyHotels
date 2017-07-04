//
//  LoginViewController.swift
//  SymphonyHotels
//
//  Created by Milan Tomasovic on 7/4/17.
//  Copyright © 2017 Milan Tomasovic. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet weak var usernameNameTextField: UITextField!
    @IBOutlet weak var passwordNameTextField: UITextField!
    
    // MARK: Actions
    
    
    /// Login
    @IBAction func loginAction() {
        guard let username = usernameNameTextField.text, let password = passwordNameTextField.text else {
            return
        }
        
        let parameters = [
            "username": username,
            "password": password
        ]
        
        RESTManager.shared.loadData(from: "\(BASE_URL)/api-token-auth/", method: .post, parameters: parameters) { [weak self] (status, response) in
            if let response = response as? JSON {
                if let token = response["token"] as? String {
                    // Store token.
                    UserDefaults.standard.set(token, forKey: TOKEN)
                    UserDefaults.standard.synchronize()
                    
                    // Show home.
                    self?.performSegue(withIdentifier: "HomeSegue", sender: nil)
                }
            }
        }
    }
    
}
