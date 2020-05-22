//
//  LoginViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/17.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        emailTextfield.text = "1@2.com"
        passwordTextfield.text = "abcd1234"
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "LogToWel", sender: self)
                }
            }
        }
    }
}
