//
//  scoreBrain.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/17.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

class ScoreData: Codable {
    let identifier: String
    var totalPoints: Int
    var totalQuizNum: Int
    var totalTime: Int
    var challengeCounts: Int
    
    init(id: String, totalPoints: Int, totalQuizNum: Int, totalTime: Int, challengeCounts: Int = 1) {
        self.identifier = id
        self.totalPoints = totalPoints
        self.totalQuizNum = totalQuizNum
        self.totalTime = totalTime
        self.challengeCounts = challengeCounts
    }
}

