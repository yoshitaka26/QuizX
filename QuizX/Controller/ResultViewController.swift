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
    var quizSetNumber: Int = 0
    var totalAnswerdtime: Float = 0
    let scoreBrain = ScoreBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.hidesBackButton = true
        
        let totalTime = Int(totalAnswerdtime)
        pointsLabel.text = "スコア \(totalPoints)点"
        timeLabel.text = "タイム \(totalTime)秒"
        returnButton.setTitle("クイズ一覧へ戻る", for: .normal)
       
        scoreBrain.scoreRecord(totalPoints, totalQuizNum, quizSetNumber, totalTime)
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
