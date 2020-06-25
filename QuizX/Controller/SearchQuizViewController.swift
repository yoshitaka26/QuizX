//
//  SearchQuizViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/06/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class SearchQuizViewCntroller: UIViewController {
    let db = Firestore.firestore()
    var quizDataFSBrain = QuizDataFSBrain()
    var quizSetArray: [QuizSet] = []
    var readyQuizFlag = false
    
    
    var timer = Timer()
    
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var quizNameField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    
    @IBAction func searchQuizbutton(_ sender: UIButton) {
        
        if let userID = addressField.text, let quizNumber = quizNameField.text {
            let email = "\(userID)@quizx.com"
            let newQuizName = email + "_" + quizNumber
            
            if userID != "", quizNumber != "" {
                searchButton.isEnabled = false
                getDataDromFS(newQuizName)
            } else {
                alertForSearchQuiz()
            }
            
        }
    }
    
    func getDataDromFS(_ newQuizName: String) {
        db.collection(newQuizName).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents of quizData: \(err)")
                self.alertForSearchQuiz()
            } else {
                for document in querySnapshot!.documents {
                    self.readyQuizFlag = true
                    if let data = document.data() as? [String: String] {
                        if let question = data["question"], let answer = data["answer"], let explication = data["explication"], let dummy1 = data["dummy1"], let dummy2 = data["dummy2"], let dummy3 = data["dummy3"] {
                            let quizSet = QuizSet(answer: answer, dummy1: dummy1, dummy2: dummy2, dummy3: dummy3, explication: explication, question: question)
                            self.quizSetArray.append(quizSet)
                            
                        } else {
                            print("fail to set data to QuizSet Model")
                            self.alertForSearchQuiz()
                        }
                    }
                }
                
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
                    
                    if self.readyQuizFlag == true {
                        self.performSegue(withIdentifier: "ToShareQuizChallenge", sender: self)
                        print(self.quizSetArray)
                    } else {
                        self.searchButton.isEnabled = true
                        self.alertForSearchQuiz()
                    }
                }
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToShareQuizChallenge" {
            let destinationVC = segue.destination as! QuizChallengeViewController
            
            destinationVC.quizSetArray.append(contentsOf: quizSetArray)
            
            destinationVC.quizShuffle = true
            
        }
    }
    
    func alertForSearchQuiz() {
        
        let alert = UIAlertController(title: "クイズが見つかりません", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
