//
//  changeNewQuizViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/29.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class changeNewQuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    var quizNumber: Int = 0
    var documentNameNum: String = ""
    
    var newQuizArray: [QuizSet] = []
    var newQuizDocId: String = ""
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explicationLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dummy1Label: UILabel!
    @IBOutlet weak var dummy2Label: UILabel!
    @IBOutlet weak var dummy3Label: UILabel!
    
    override func viewDidLoad() {
        
        if quizNumber + 1 < 10 {
            documentNameNum = "0\(quizNumber + 1)"
        } else {
            documentNameNum = String(quizNumber + 1)
        }
        
        let quiz = newQuizArray[quizNumber]
        questionLabel.text = quiz.question
        explicationLabel.text = quiz.explication
        answerLabel.text = quiz.answer
        dummy1Label.text = quiz.dummy1
        dummy2Label.text = quiz.dummy2
        dummy3Label.text = quiz.dummy3
    }
    
    
    
    @IBAction func questionChangeButton(_ sender: UIButton) {
        let name = "問題"
        
        writeQuiz(name: name, label: questionLabel)
    }
    
    @IBAction func explicationChangeButton(_ sender: UIButton) {
        let name = "解説"
        
        writeQuiz(name: name, label: explicationLabel)
    }
    @IBAction func answerChangeButton(_ sender: UIButton) {
        let name = "正解"
        
        writeQuiz(name: name, label: answerLabel)
    }
    
    @IBAction func dummy1ChangeButton(_ sender: UIButton) {
        let name = "誤答１"
        
        writeQuiz(name: name, label: dummy1Label)
    }
    @IBAction func dummy2ChangeButton(_ sender: UIButton) {
        let name = "誤答２"
        
        writeQuiz(name: name, label: dummy2Label)
    }
    
    @IBAction func dummy3ChangeButton(_ sender: UIButton) {
        let name = "誤答３"
        
        writeQuiz(name: name, label: dummy3Label)
    }
    
    @IBAction func quizChangeButton(_ sender: UIButton) {
        
        if let question = questionLabel.text, let explication = explicationLabel.text, let answer = answerLabel.text, let dummy1 = dummy1Label.text, let dummy2 = dummy2Label.text, let dummy3 = dummy3Label.text {
            
            let newQuiz = QuizSet(answer: answer, dummy1: dummy1, dummy2: dummy2, dummy3: dummy3, explication: explication, question: question)
            
            newQuizArray[quizNumber] = newQuiz
            
            recodeNewQuizToFS(newQuiz: newQuiz)
            
        }
        
        performSegue(withIdentifier: "ToQuizTable", sender: self)
    }
    
    @IBAction func quizDeleteButton(_ sender: UIButton) {
        
        newQuizArray.remove(at: quizNumber)
        
        deleteNewQuizFromFS()
        
        performSegue(withIdentifier: "ToQuizTable", sender: self)
    }
    
    
    func writeQuiz(name: String, label: UILabel) {
        var textFiled = UITextField()
        
        let alert = UIAlertController(title: "クイズ作成", message: "\(name)", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "追加", style: .default) { (action) in
            label.text = textFiled.text!
        }
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "..."
            
            textFiled = alertTextFiled
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func recodeNewQuizToFS(newQuiz: QuizSet) {
        
        if let email = Auth.auth().currentUser?.email {
            db.collection(email).document(newQuizDocId).setData([
                "answer": newQuiz.answer,
                "dummy1": newQuiz.dummy1,
                "dummy2": newQuiz.dummy2,
                "dummy3": newQuiz.dummy3,
                "explication": newQuiz.explication,
                "question": newQuiz.question
            ]) { (error) in
                if let err = error {
                    print("Error writing document: \(err)")
                }
                print("Document successfully written!")
            }
        }
    }
    
    func deleteNewQuizFromFS() {
        if let email = Auth.auth().currentUser?.email {
            db.collection(email).document(newQuizDocId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizTable" {
            let destinationVC = segue.destination as! NewQuizTableViewController
            
            destinationVC.newQuizArray.append(contentsOf: newQuizArray)
        }
    }
}

