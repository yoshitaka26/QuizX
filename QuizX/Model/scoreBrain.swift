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
    let quizNames = QuizName()
    
    func scoreRecord(_ totalPoints: Int, _ totalQuizNum: Int, _ quizSetNumber: Int, _ totalTime: Int) {
        
        let name = quizNames.quizName[quizSetNumber]  //"quizData1_1"
        var recode: [Int] = [totalPoints, totalQuizNum, totalTime, 1]
        
        if let data = userDefault.array(forKey: name) as? [Int] {
            recode[3] = data[3] + 1
            if data[0] > totalPoints {
                recode[0] = data[0]
                recode[2] = data[2]
            } else if data[0] == totalPoints {
                if data[2] < totalTime {
                recode[2] = data[2]
                }
            }
            userDefault.set(recode, forKey: name)
        } else {
            userDefault.set(recode, forKey: name)
        }
        
    }
}
