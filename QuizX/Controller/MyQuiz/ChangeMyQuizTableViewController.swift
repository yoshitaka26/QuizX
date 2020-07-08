//
//  ChangeMyQuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/07/02.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class ChangeMyQuizTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var quizSetArray: [QuizSet] = []
    var myQuizName: String = ""
    var newQuizDocId: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDocumentID()
        
        db.collection(myQuizName).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents of quizData: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let data = document.data() as? [String: String] {
                        if let question = data["question"], let answer = data["answer"], let explication = data["explication"], let dummy1 = data["dummy1"], let dummy2 = data["dummy2"], let dummy3 = data["dummy3"] {
                            let quizSet = QuizSet(answer: answer, dummy1: dummy1, dummy2: dummy2, dummy3: dummy3, explication: explication, question: question)
                            self.quizSetArray.append(quizSet)
                            
                            self.tableView.reloadData()
                            
                        } else {
                            print("fail to set data to QuizSet Model")
                        }
                    }
                }
                
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quizSetArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = quizSetArray[indexPath.row].question
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToChaneMyQuizView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToChaneMyQuizView" {
            let destinationVC = segue.destination as! ChangeMyQuizViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.newQuizDocId = newQuizDocId[indexPath.row]
                destinationVC.quizNumber = indexPath.row
                destinationVC.quizSet = quizSetArray[indexPath.row]
            }
            
            
            destinationVC.myQuizName = myQuizName
        }
    }
    
    func getDocumentID() {
        db.collection(myQuizName).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.newQuizDocId.append(document.documentID)
                }
            }
        }
        
    }
}
