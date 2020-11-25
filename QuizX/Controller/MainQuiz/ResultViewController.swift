//
//  ResultViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit


class ResultViewController: UIViewController {
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var totalPoints: Int = 0
    var totalQuizNum: Int = 0
    var quizSetName: String? = nil  //初級クイズ１...
    var totalAnswerdtime: Float = 0
    
    var scoreBrain = ScoreDataRecordBrain()
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        
        let totalTime = Int(totalAnswerdtime)
        pointsLabel.text = "正解数 \(totalPoints)問"
        
        if totalTime != 0 {
            timeLabel.text = "タイム \(totalTime)秒"
            logoView.image = #imageLiteral(resourceName: "rogoblack")
        } else {
            timeLabel.text = "ゲームオーバー"
            logoView.image = #imageLiteral(resourceName: "rogowhite")
        }
        
        if let scoreName = quizSetName {
            if scoreName == K.QName.challenge {
                scoreBrain.calculateScore(totalPoints, totalQuizNum, scoreName, totalTime)
            } else {
                if totalTime != 0 {
                    scoreBrain.calculateScore(totalPoints, totalQuizNum, scoreName, totalTime)
                } else {
                    scoreBrain.calculateScore(0, totalQuizNum, scoreName, totalTime)
                }
            }
        }
    }
    
    @IBAction func backToHomeButton(_ sender: UIButton) {
        performSegue(withIdentifier: "backToHome", sender: self)
    }
}
