//
//  CreateOperationViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/28.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class CreateOperationViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var newQuizArray: [QuizSet] = []
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var explicationLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dummy1Label: UILabel!
    @IBOutlet weak var dummy2Label: UILabel!
    @IBOutlet weak var dummy3Label: UILabel!
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func questionButton(_ sender: UIButton) {
        let name = "問題"
        
        writeQuiz(name: name, label: questionLabel)
    }
    
    @IBAction func explicationButton(_ sender: UIButton) {
        let name = "解説"
        
        writeQuiz(name: name, label: explicationLabel)
    }
    
    @IBAction func answerButton(_ sender: UIButton) {
        let name = "正解"
        
        writeQuiz(name: name, label: answerLabel)
    }
    
    @IBAction func dummy1Button(_ sender: UIButton) {
        let name = "誤答１"
        
        writeQuiz(name: name, label: dummy1Label)
    }
    
    @IBAction func dummy2Button(_ sender: UIButton) {
        let name = "誤答２"
        
        writeQuiz(name: name, label: dummy2Label)
    }
    
    @IBAction func dummy3Button(_ sender: UIButton) {
        let name = "誤答３"
        
        writeQuiz(name: name, label: dummy3Label)
    }
    
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        
        if let question = questionLabel.text, let explication = explicationLabel.text, let answer = answerLabel.text, let dummy1 = dummy1Label.text, let dummy2 = dummy2Label.text, let dummy3 = dummy3Label.text {
            
            let newQuiz = QuizSet(answer: answer, dummy1: dummy1, dummy2: dummy2, dummy3: dummy3, explication: explication, question: question)
            
            newQuizArray.append(newQuiz)
            
            recodeNewQuizToFS(newQuiz: newQuiz)
        }
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
        
        let documentName = "newQuiz\(Date().timeIntervalSince1970)"
        
        if let email = Auth.auth().currentUser?.email {
            db.collection(email).document(documentName).setData([
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
        performSegue(withIdentifier: "ToCreateQuizMain", sender: self)
    }
}
