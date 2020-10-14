//
//  CreatQuizMainViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/28.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class CreateQuizMainViewController: UIViewController {
    
    var newQuizArray: [QuizDataSet] = []
    
    let myQuizDataModel = MyQuizDataModel()
    
    override func viewDidLoad() {
        
        self.navigationItem.hidesBackButton = true
        
        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = ""
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    
    @IBAction func createNewQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToCreateOperation", sender: self)
    }
    
    @IBAction func changeNewQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToNewQuizTable", sender: self)
    }
    
    @IBAction func NewQuizChallengeButton(_ sender: UIButton) {
        
        if let myQuiz = myQuizDataModel.loadItems() {
            newQuizArray = myQuiz
            
            if newQuizArray.count == 0 {
                alertForNoQuiz()
            } else {
                performSegue(withIdentifier: "ToQuizView", sender: self)
            }        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizView" {
            let destinationVC = segue.destination as! QuizViewController
            
            destinationVC.quizSetArray.append(contentsOf: newQuizArray)
            destinationVC.quizSetName = nil
            destinationVC.quizQNumber = 0
            destinationVC.quizEndQNumber = newQuizArray.count
            destinationVC.navigationItem.hidesBackButton = false
        }
    }
    
    
    //MARK: - Alert
    func alertForNoQuiz() {
        
        let alert = UIAlertController(title: "クイズがありません", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
