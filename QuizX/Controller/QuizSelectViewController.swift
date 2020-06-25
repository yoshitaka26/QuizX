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
    var quizDataFSBrain = QuizDataFSBrain()
    var namesBeginner: [String] = []
    var namesIntermediate: [String] = []
    var namesAdvanced: [String] = []
    
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
            
            destinationVC.quizNamesArray.append(contentsOf: namesBeginner)  //初級クイズ...
            
            quizDataFSBrain.loadQuizDataFromFS(with: "quizDataBeginner") { (quizSet) in
                destinationVC.quizSetArray.append(contentsOf: quizSet) //{QuizData x 10...}
            }
            
        }
        else if segue.identifier == "ToIntQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizNamesArray.append(contentsOf: namesIntermediate) //中級クイズ...
            
            quizDataFSBrain.loadQuizDataFromFS(with: "quizDataIntermediate") { (quizSet) in
                destinationVC.quizSetArray.append(contentsOf: quizSet) //{QuizData x 10...}
            }
        }
        else if segue.identifier == "ToAdvQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizNamesArray.append(contentsOf: namesAdvanced)  //上級クイズ...
            
            quizDataFSBrain.loadQuizDataFromFS(with: "quizDataAdvanced") { (quizSet) in
                destinationVC.quizSetArray.append(contentsOf: quizSet) //{QuizData x 10...}
            }
        } else if segue.identifier == "ToChallengeQuiz" {
            let destinationVC = segue.destination as! QuizChallengeViewController
            
            quizDataFSBrain.loadQuizDataFromFS(with: "quizDataBeginner") { (quizSet) in
                destinationVC.quizSetArray.append(contentsOf: quizSet) //{QuizData x 10...}
            }
            
            quizDataFSBrain.loadQuizDataFromFS(with: "quizDataIntermediate") { (quizSet) in
                destinationVC.quizSetArray.append(contentsOf: quizSet)
            }
            
            quizDataFSBrain.loadQuizDataFromFS(with: "quizDataAdvanced") { (quizSet) in destinationVC.quizSetArray.append(contentsOf: quizSet)
            }
            
            destinationVC.quizShuffle = true
            
        }
    }
}
