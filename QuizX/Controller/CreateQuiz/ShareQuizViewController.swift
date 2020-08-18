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
    var qNum: String = ""
    
    @IBOutlet weak var quizNumber: UITextField!
    @IBOutlet weak var numberOfQuiz: UILabel!
    
    override func viewDidLoad() {
        numberOfQuiz.text = String(newQuizArray.count)
    }
    
    
    @IBAction func shareQuizButton(_ sender: UIButton) {
        if let qNumber = quizNumber.text {
            if let quizNumber = Int(qNumber) {
                if newQuizArray.count > 9 {
                    if let email = Auth.auth().currentUser?.email {
                        qNum = String(quizNumber)
                        let qName = email + "_" + String(quizNumber)
                        quizDataFSBrain.recodeNewQuizToFS(quizName: qName, newQuiz: newQuizArray)
                        
                        db.collection("myQuiz").addDocument(data: [
                            "flag": true,
                            "date": Date().timeIntervalSince1970,
                            "email": email,
                            "myQuizName": qName,
                            "myQuizNum": String(quizNumber),
                            "totalQuizNum": newQuizArray.count]) { (error) in
                                if let e = error {
                                    print("There was an issue saving data to firestore. \(e)")
                                } else {
                                    print("Successfully saved data")
                                }
                        }
                        alertForCompleteShareQuiz()
                    }
                } else {
                    alertForQuizCounts()
                }
            } else {
                alertForQuizNumber()
            }
        }
    }
    
    func alertForCompleteShareQuiz() {
        
        let alert = UIAlertController(title: "クイズ番号『\(qNum)』で\nクイズがシェアされました", message: "", preferredStyle: .alert)
        
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
