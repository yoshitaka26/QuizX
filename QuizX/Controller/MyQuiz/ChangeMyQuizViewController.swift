//
//  ChangeMyQuizViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/07/02.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation
import Firebase

class ChangeMyQuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    var myQuizName: String = ""
    
    var quizNumber: Int = 0
    var quizSet: QuizSet? = nil
    var newQuizDocId: String = ""
    
    @IBOutlet weak var question: UITextView!
    @IBOutlet weak var explication: UITextView!
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var dummy1: UITextField!
    @IBOutlet weak var dummy2: UITextField!
    @IBOutlet weak var dummy3: UITextField!
    
    override func viewDidLoad() {
        if let quizSet = quizSet {
            question.text = quizSet.question
            explication.text = quizSet.explication
            answer.text = quizSet.answer
            dummy1.text = quizSet.dummy1
            dummy2.text = quizSet.dummy2
            dummy3.text = quizSet.dummy3
        }
    }
    
    @IBAction func changeButton(_ sender: UIButton) {
        let q = question.text ?? ""
        let e = explication.text ?? ""
        let a = answer.text ?? ""
        let d1 = dummy1.text ?? ""
        let d2 = dummy2.text ?? ""
        let d3 = dummy3.text ?? ""
        
        db.collection(myQuizName).document(newQuizDocId).setData([
            "answer": a,
            "dummy1": d1,
            "dummy2": d2,
            "dummy3": d3,
            "explication": e,
            "question": q
        ]) { (error) in
            if let err = error {
                print("Error writing document: \(err)")
            }
            print("Document successfully written!")
        }
        
        performSegue(withIdentifier: "backToMyQuizSet", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToMyQuizSet" {
            let destinationVC = segue.destination as! ChangeMyQuizTableViewController
            
            destinationVC.myQuizName = myQuizName
            destinationVC.navigationItem.hidesBackButton = true
        }
        
    }
}
