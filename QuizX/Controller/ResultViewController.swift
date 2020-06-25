//
//  ResultViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit


class ResultViewController: UIViewController {
    
    @IBOutlet weak var returnButton: UIButton!
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var totalPoints: Int = 0
    var totalQuizNum: Int = 0
    var quizSetName: String? = ""
    var totalAnswerdtime: Float = 0
    let scoreBrain = ScoreBrain()
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        
        let totalTime = Int(totalAnswerdtime)
        pointsLabel.text = "正解数 \(totalPoints)問"
        
        if totalTime != 0 {
            timeLabel.text = "タイム \(totalTime)秒"
        } else {
            timeLabel.text = "ゲームオーバー"
        }
        
        returnButton.setTitle("クイズ一覧へ戻る", for: .normal)
       
        if totalTime != 0 {
            scoreBrain.scoreRecord(totalPoints, totalQuizNum, quizSetName, totalTime)
        }
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        
    }
    
}
