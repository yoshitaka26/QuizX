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
    var quizDataFSBrain = QuizDataFSBrain()
    var quizNamesArray: [String] = []
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var scoreButton: UIButton!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        
        mainLabel.text = "QuizX"
        quizButton.setTitle("クイズ一覧", for: .normal)
        scoreButton.setTitle("成績一覧", for: .normal)
        scoreLabel.text = "\(userDefault.integer(forKey: "QuizX"))🔔"
        
        quizDataFSBrain.loadQuizDataNameFromFS { (names) in
                   self.quizNamesArray.append(contentsOf: names)
               }
    }
    
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizList", sender: self)
    }
    
    @IBAction func scoreButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToResultView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "ToQuizList" {
              let destinationVC = segue.destination as! QuizTableViewController
              
              destinationVC.quizNamesArray.append(contentsOf: quizNamesArray)
          }
          else if segue.identifier == "ToResultView" {
            let destinationVC = segue.destination as! ResultTableViewController
            
            destinationVC.quizNamesArray.append(contentsOf: quizNamesArray)
        }
      }
}



