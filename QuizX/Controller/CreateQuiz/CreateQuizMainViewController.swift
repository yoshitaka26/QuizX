//
//  CreatQuizMainViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/28.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class CreateQuizMainViewController: UIViewController {
    
    let db = Firestore.firestore()
    var quizDataFSBrain = QuizDataFSBrain()
    
    var newQuizArray: [QuizSet] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        newQuizArray = []
        
        if let email = Auth.auth().currentUser?.email {
            quizDataFSBrain.loadQuizDataFromFS(with: email) { (quizSet) in
                self.newQuizArray.append(contentsOf: quizSet)
            }
        }
    }
    
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    @IBAction func createNewQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToCreateOperation", sender: self)
    }
    
    @IBAction func changeNewQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToNewQuizTable", sender: self)
    }
    
    @IBAction func NewQuizChallengeButton(_ sender: UIButton) {
        
        if newQuizArray.count == 0 {
            alertForNoQuiz()
        } else {
            performSegue(withIdentifier: "ToQuizView", sender: self)
        }
    }
    
    @IBAction func shareQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizShare", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCreateOperation" {
            let destinationVC = segue.destination as! CreateOperationViewController
            
            destinationVC.newQuizArray.append(contentsOf: newQuizArray)
        } else if segue.identifier == "ToNewQuizTable" {
            let destinationVC = segue.destination as! NewQuizTableViewController
            
            destinationVC.newQuizArray.append(contentsOf: newQuizArray)
        } else if segue.identifier == "ToQuizView" {
            let destinationVC = segue.destination as! QuizViewController
            
            destinationVC.quizSetArray.append(contentsOf: newQuizArray)
            destinationVC.quizSetName = nil
            destinationVC.quizQNumber = 0
            destinationVC.quizEndQNumber = newQuizArray.count
            destinationVC.navigationItem.hidesBackButton = false
        } else if segue.identifier == "ToQuizShare" {
            let destinationVC = segue.destination as! ShareQuizViewController
            
            destinationVC.newQuizArray.append(contentsOf: newQuizArray)
        }
    }
    
    
    //MARK: - Alert
    func alertForNoQuiz() {
        
        let alert = UIAlertController(title: "クイズがありません", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
