//
//  SharedMyQuizChangeTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/07/01.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class SharedMyQuizChangeTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var myQuiz: [MyQuiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        
        if let email = Auth.auth().currentUser?.email {
            db.collection("myQuiz").addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firebase \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let flag = data["flag"] as? Bool, let qEmail = data["email"] as? String {
                                if flag && qEmail == email {
                                    if let date = data["date"] as? Double, let myQuizName = data["myQuizName"] as? String, let myQuizNum = data["myQuizNum"] as? String, let totalQuizNum = data["totalQuizNum"] as? Int {
                                        let quizData = MyQuiz(date: date, myQuizName: myQuizName, myQuizNum: myQuizNum, totalQuizNum: totalQuizNum)
                                        self.myQuiz.append(quizData)
                                        
                                        self.tableView.reloadData()
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myQuiz.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        
        let data = myQuiz[indexPath.row]
        
        cell.quizName.text = "クイズ番号　\(data.myQuizNum)"
        cell.scoreLabel.text = ""
        cell.timeLabel.text = "問題数　\(data.totalQuizNum)問"
        cell.tryLabel.text = ""
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToChaneMyQuizTable", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToChaneMyQuizTable" {
            let destinationVC = segue.destination as! ChangeMyQuizTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.myQuizName = myQuiz[indexPath.row].myQuizName
            }
        }
    }
}
