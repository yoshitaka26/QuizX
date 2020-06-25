//
//  ShareQuizViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/06/09.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase


class ShareQuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    var quizDataFSBrain = QuizDataFSBrain()
    var newQuizArray: [QuizSet] = []
    
    @IBOutlet weak var numberOfQuiz: UILabel!
    @IBOutlet weak var quizName: UILabel!
    
    override func viewDidLoad() {
        numberOfQuiz.text = String(newQuizArray.count)
    }
    
    @IBAction func changeQuizNameButton(_ sender: UIButton) {
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "クイズ番号", message: "0以外から始まる数字", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "追加", style: .default) { (action) in
            self.quizName.text = textFiled.text!
        }
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "1234"
            
            textFiled = alertTextFiled
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func shareQuizButton(_ sender: UIButton) {
        if let quizNumber = Int(quizName.text!) {
            if newQuizArray.count > 9 {
                if let email = Auth.auth().currentUser?.email {
                    let qName = email + "_" + String(quizNumber)
                    quizDataFSBrain.recodeNewQuizToFS(quizName: qName, newQuiz: newQuizArray)
                    alertForCompleteShareQuiz()
                }
            } else {
                alertForQuizCounts()
            }
        } else {
            alertForQuizNumber()
        }
        
        
    }
    
    func alertForCompleteShareQuiz() {
        
        let alert = UIAlertController(title: "クイズがシェアされました", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.performSegue(withIdentifier: "ToCreateQuizMain", sender: self)
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForQuizCounts() {
        
        let alert = UIAlertController(title: "クイズの数が足りません", message: "10問以上必要です", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func alertForQuizNumber() {
        
        let alert = UIAlertController(title: "クイズ番号は数字のみ有効です", message: "", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
