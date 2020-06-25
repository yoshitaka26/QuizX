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
    var quizSetArray: [QuizSet] = [] //{QuiData x 10...}
    var quizShuffle: Bool = false
    
    var quizSetName: String = ""  //初級クイズ１...
    var quizSetNumber: Int = 0  //indexPath.row
    
    @IBOutlet weak var QuizChallengeButton: UIButton!
    
    @IBAction func QuizChallengeButton(_ sender: UIButton) {
        
        if quizSetNumber * 10 < quizSetArray.count - 9 {
              performSegue(withIdentifier: "ToQuizView", sender: self)
        } else {
            DispatchQueue.main.async {
                self.QuizChallengeButton.setTitle("クイズ準備中", for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizView" {
            let destinationVC = segue.destination as! QuizViewController
            
            if quizShuffle == false {
                destinationVC.quizSetArray.append(contentsOf: quizSetArray) //{QuiData x 10...}
                destinationVC.quizSetName = quizSetName  //初級クイズ１...
                
                if quizSetNumber == 0 {
                    destinationVC.quizQNumber = 0
                    destinationVC.quizEndQNumber = 10
                } else {
                    let qNum = quizSetNumber * 10
                    destinationVC.quizQNumber = qNum
                    destinationVC.quizEndQNumber = qNum + 10
                }
                destinationVC.quizSetNumber = quizSetNumber   //indexPath.row
            } else if quizShuffle == true {
                quizSetArray.shuffle()
                destinationVC.quizSetArray.append(contentsOf: quizSetArray)
                destinationVC.quizSetName = nil
                destinationVC.quizQNumber = 0
                destinationVC.quizEndQNumber = quizSetArray.count
            }
        }
    }
    
}
