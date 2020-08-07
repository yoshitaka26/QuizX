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
        emailTextfield.text = ""
        passwordTextfield.text = ""
    }
    
    @IBAction func logInPressed(_ sender: UIButton) {
        if let userID = emailTextfield.text, let password = passwordTextfield.text {
            let email = "\(userID)@quizx.net"
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error {
                    print(e)
                    self.alertForSearchQuiz()
                } else {
                    self.performSegue(withIdentifier: "LogToWel", sender: self)
                }
            }
        }
    }
    
    func alertForSearchQuiz() {
           
           let alert = UIAlertController(title: "ログインに失敗しました", message: "", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           
           present(alert, animated: true, completion: nil)
       }
}
