//
//  QuizChallengeViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/21.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class QuizChallengeViewController: UIViewController {
    
    let db = Firestore.firestore()
    let quizDataFSBrain = QuizDataFSBrain()
    var quizSetArray: [QuizSet] = []
    
    var quizSetFileName: String = ""
    var quizSetNumber: Int = 0
    
    @IBOutlet weak var QuizChallengeButton: UIButton!
    
    @IBAction func QuizChallengeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizView" {
            let destinationVC = segue.destination as! QuizViewController
            
            destinationVC.quizSetArray.append(contentsOf: quizSetArray)
            destinationVC.quizSetFileName = quizSetFileName  //quizNames[indexPath.row]
            destinationVC.quizSetNumber = quizSetNumber   //indexPath.row
        }
    }
    
}
