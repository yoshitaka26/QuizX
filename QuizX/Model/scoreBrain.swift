//
//  scoreBrain.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/17.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct ScoreBrain {
    
    let userDefault = UserDefaults.standard
    var quizDataExcelBrain = QuizDataExcelBrain()
    
    func scoreRecord(_ totalPoints: Int, _ totalQuizNum: Int, _ quizSetNumber: Int, _ totalTime: Int) {
        
        let quizSetName = quizDataExcelBrain.quizDataSetNameArray[quizSetNumber]
        let scoreKey = quizSetName + "t"
        let pointKey = quizSetName + "p"
        let curretPoint = userDefault.integer(forKey: pointKey)
        
        let allPoints = userDefault.integer(forKey: "QuizX") + totalPoints
        userDefault.set(allPoints, forKey: "QuizX")
        
        if totalPoints >= curretPoint {
            let score = "\(totalPoints) / \(totalQuizNum)"
                   userDefault.set(score, forKey: quizSetName)
                   userDefault.set(totalTime, forKey: scoreKey)
                   userDefault.set(totalPoints, forKey: pointKey)
        }
    }
}
