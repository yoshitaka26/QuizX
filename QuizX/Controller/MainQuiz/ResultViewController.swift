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
    
    var guestLogin = false
    
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
                let formatter = DateFormatter()
                formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "ydMMM", options: 0, locale: Locale(identifier: "ja_JP"))
                let dateToday = formatter.string(from: Date())
                
                db.collection("myQuiz").addDocument(data: [
                    "date": dateToday,
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
        if !guestLogin {
            if let scoreName = quizSetName {
                if scoreName == K.QName.challenge {
                    scoreBrain.scoreRecord(totalPoints, totalQuizNum, scoreName, totalTime)
                } else {
                    if totalTime != 0 {
                        scoreBrain.scoreRecord(totalPoints, totalQuizNum, scoreName, totalTime)
                    } else {
                        scoreBrain.scoreRecord( 0, totalQuizNum, scoreName, totalTime)
                    }
                }
            }
        }
    }
    @IBAction func backToHomeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "backToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToHome" {
            let destinationVC = segue.destination as! WelcomViewCntroller
            if guestLogin {
                destinationVC.guestLogin = true
            }
        }
    }
}
