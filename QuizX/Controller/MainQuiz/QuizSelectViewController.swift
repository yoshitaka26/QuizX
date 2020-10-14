//
//  QuizSelectViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/24.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class QuizSelectViewController: UIViewController {
    
    let quizDataExcelBrain = QuizDataExcelBrain()
    
    @IBOutlet weak var challengeButton: UIButton!
    
    override func viewDidLoad() {
       let backBarButtonItem = UIBarButtonItem()
       backBarButtonItem.title = ""
       self.navigationItem.backBarButtonItem = backBarButtonItem
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
            destinationVC.quizNamesArray = quizDataExcelBrain.namesBeginner
            
        }
        else if segue.identifier == "ToIntQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizDataName = K.QName.intermediate
            destinationVC.quizNamesArray = quizDataExcelBrain.namesIntermediate
            
        }
        else if segue.identifier == "ToAdvQuizList" {
            let destinationVC = segue.destination as! QuizTableViewController
            
            destinationVC.quizDataName = K.QName.advanced
            destinationVC.quizNamesArray = quizDataExcelBrain.namesAdvanced
            
        } else if segue.identifier == "ToChallengeQuiz" {
            let destinationVC = segue.destination as! QuizChallengeViewController
            
            destinationVC.quizShuffle = true
            destinationVC.quizSetName = K.QName.challenge
            
        }
    }
}
