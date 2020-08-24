//
//  WelcomViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/14.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class WelcomViewCntroller: UIViewController {
    
    let db = Firestore.firestore()
    var guestLogin = false
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var UserQuizButton: UIButton!
    @IBOutlet weak var myQuizButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    
    
    
    override func viewDidLoad() {
        if guestLogin {
            myQuizButton.isEnabled = false
            myQuizButton.setTitle("", for: .normal)
            UserQuizButton.isEnabled = false
            UserQuizButton.setTitle("", for: .normal)
            scoreButton.isEnabled = false
            scoreButton.setTitle("", for: .normal)
        }
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizSelect", sender: self)
    }
    
    @IBAction func myQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToMyQuiz", sender: self)
    }
    
    @IBAction func sharedMyQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToSharedMyQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizSelect" {
            let destinationVC = segue.destination as! QuizSelectViewController
            if guestLogin {
                destinationVC.guestLogin = true
                
            }
            
        }
    }
}



