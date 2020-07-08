//
//  QuizHistoryTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/07/01.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class QuizHistoryTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var myQuiz: [MyQuizScoreData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        
        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        
        
        if let email = Auth.auth().currentUser?.email {
            db.collection("myQuiz").addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue retrieving data from Firebase \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let mail = data["playerEmail"] as? String {
                                if mail == email {
                                    if let email = data["email"] as? String, let myQuizNum = data["myQuizNum"] as? String, let totalPoints = data["totalPoints"] as? Int, let totalQuizNum = data["totalQuizNum"] as? Int, let totalTime = data["totalTime"] as? Int {
                                        let score = MyQuizScoreData(email: email, myQuizNum: myQuizNum, totalpoints: totalPoints, totalQuizNum: totalQuizNum, totalTime: totalTime)
                                        
                                        self.myQuiz.append(score)
                                        
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
        // #warning Incomplete implementation, return the number of rows
        return myQuiz.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        
        let data = myQuiz[indexPath.row]
        let quizName = "\(data.email)\n\(data.myQuizNum)"
        cell.quizName.text = quizName
        cell.scoreLabel.text = "スコア \(myQuiz[indexPath.row].totalpoints) / \(myQuiz[indexPath.row].totalQuizNum)"
        let time = myQuiz[indexPath.row].totalTime
        if time != 0 {
            cell.timeLabel.text = "タイム \(time)秒"
        } else {
            cell.timeLabel.text = "ゲームオーバー"
        }
        
        cell.tryLabel.text = ""
        
        
        return cell
    }
}
