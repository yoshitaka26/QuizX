//
//  SharedMyQuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/06/27.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class SharedMyQuizTableViewController: UITableViewController {
    
    let db = Firestore.firestore()
    
    var myQuizData: [MyQuizData] = []
    
    
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
                            if let qEmail = data["email"] as? String {
                                if qEmail == email {
                                    if let date = data["date"] as? Double, let myQuizNum = data["myQuizNum"] as? String, let playerEmail = data["playerEmail"] as? String, let totalPoints = data["totalPoints"] as? Int, let totalQuizNum = data["totalQuizNum"] as? Int {
                                        let quizData = MyQuizData(date: date, myQuizNum: myQuizNum, playerEmail: playerEmail, totalpoints: totalPoints, totalQuizNum: totalQuizNum)
                                    self.myQuizData.append(quizData)
                                    
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
        return myQuizData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        
        let data = myQuizData[indexPath.row]
        let date = data.date
        let roundDate = Int64((date * 1000.0).rounded())
        let triedDate = Date(milliseconds: Int64(roundDate))
        cell.quizName.text = "\(data.myQuizNum)"
        cell.scoreLabel.text = "スコア \(data.totalpoints) / \(data.totalQuizNum)"
        cell.timeLabel.text = data.playerEmail
        cell.tryLabel.text = "\(triedDate)"
     
        
        return cell
    }
}


extension Date {
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}


//Date().millisecondsSince1970 // 1476889390939
//Date(milliseconds: 0) // "Dec 31, 1969, 4:00 PM" (PDT variant of 1970 UTC)
