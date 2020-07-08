//
//  RegisterViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/17.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        emailTextfield.text = "うなぎ"
        passwordTextfield.text = "abcd1234"
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let userID = emailTextfield.text, let password = passwordTextfield.text {
            let email = "\(userID)@quizx.net"
            Auth.auth().createUser(withEmail: email, password: password) { (authResults, error) in
                if let e = error {
                    print(e.localizedDescription)
                    self.alertForSearchQuiz()
                } else {
                    self.getMyQuizData(email: email)
                    self.performSegue(withIdentifier: "RegToWel", sender: self)
                }
            }
        }
    }
    
    func getMyQuizData(email: String) {
        let documentName = "newQuiz\(Date().timeIntervalSince1970)"
        
        db.collection(email).document(documentName).setData([
            "answer": "エックス",
            "dummy1": "ゼット",
            "dummy2": "エフ",
            "dummy3": "アール",
            "explication": "エックス",
            "question": "アルファベットの「Ｘ」　何と読む？"
        ]) { (error) in
            if let err = error {
                print("Error writing document: \(err)")
            }
            print("Document successfully written!")
        }
    }
    
    func alertForSearchQuiz() {
           
           let alert = UIAlertController(title: "登録に失敗しました", message: "", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           
           present(alert, animated: true, completion: nil)
       }
}
