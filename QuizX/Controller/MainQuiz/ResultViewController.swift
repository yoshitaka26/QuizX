//
//  ResultViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase


class ResultViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var totalPoints: Int = 0
    var totalQuizNum: Int = 0
    var quizSetName: String? = nil  //初級クイズ１...
    var totalAnswerdtime: Float = 0
    var myQuizName: String? = nil
    var myQUizNum: String? = nil
    var myQuizEmail: String? = nil
    let scoreBrain = ScoreBrain()
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        
        let totalTime = Int(totalAnswerdtime)
        pointsLabel.text = "正解数 \(totalPoints)問"
        
        if totalTime != 0 {
            timeLabel.text = "タイム \(totalTime)秒"
            logoView.image = #imageLiteral(resourceName: "logonormal")
            if totalPoints == totalQuizNum {
                logoView.image = #imageLiteral(resourceName: "logohappy")
            }
        } else {
            timeLabel.text = "ゲームオーバー"
            logoView.image = #imageLiteral(resourceName: "logoxx")
        }

        
        if let name = myQuizName, let num = myQUizNum, let qEmail = myQuizEmail {
            if let email = Auth.auth().currentUser?.email {
                
                db.collection("myQuiz").addDocument(data: [
                    "date": Date().timeIntervalSince1970,
                    "email": qEmail,
                    "myQuizName": name,
                    "myQuizNum" : num,
                    "playerEmail": email,
                    "totalPoints": totalPoints,
                    "totalQuizNum": totalQuizNum,
                    "totalTime": totalTime
                ]) { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore. \(e)")
                    } else {
                        print("Successfully saved data")
                    }
                }
            }
        }
        
        if let scoreName = quizSetName {
            if totalTime != 0 {
                scoreBrain.scoreRecord(totalPoints, totalQuizNum, scoreName, totalTime)
            } else {
                scoreBrain.scoreRecord( 0, totalQuizNum, scoreName, totalTime)
            }
        }
    }
    
}
