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
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var myQuizButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    

    
    override func viewDidLoad() {
        
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
}



