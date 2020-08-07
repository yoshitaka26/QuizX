//
//  QuizSelectViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/24.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class QuizSelectViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func beginnerQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToBegQuizList", sender: self)
    }
    
    @IBAction func intermediateQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToIntQuizList", sender: self)
    }
    
    @IBAction func advancedQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToAdvQuizList", sender: self)
    }
    
    @IBAction func challengeQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToChallengeQuiz", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToBegQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizDataName = K.QName.beginner
        }
        else if segue.identifier == "ToIntQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizDataName = K.QName.intermediate
        }
        else if segue.identifier == "ToAdvQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizDataName = K.QName.advanced
        } else if segue.identifier == "ToChallengeQuiz" {
            let destinationVC = segue.destination as! QuizChallengeViewController

            destinationVC.quizShuffle = true
        }
    }
}
