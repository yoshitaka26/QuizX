//
//  NewQuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/29.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class NewQuizTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var newQuizArray: [QuizSet] = []
    var newQuizDocId: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDocumentID()
        
        self.navigationItem.hidesBackButton = true
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newQuizArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewQuiz", for: indexPath)
        
        cell.textLabel?.text = newQuizArray[indexPath.row].question
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToChangeNewQuiz", sender: self)
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ToCreateQuizMain", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToChangeNewQuiz" {
            let destinationVC = segue.destination as! changeNewQuizViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.newQuizDocId = newQuizDocId[indexPath.row]
                destinationVC.quizNumber = indexPath.row
            }
            
            destinationVC.newQuizArray.append(contentsOf: newQuizArray)
        } else if segue.identifier == "ToCreateQuizMain" {
            let destinationVC = segue.destination as! CreateQuizMainViewController
            
            destinationVC.navigationItem.hidesBackButton = true
        }
    }
    
    func getDocumentID() {
        
        if let email = Auth.auth().currentUser?.email {
            db.collection(email).getDocuments() { (querySnapshot, err) in
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
}

