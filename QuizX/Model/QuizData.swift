//
//  QuizData.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct QuizData {
    let question: String
    let answers: [String]
    let correct: Int
    let explanation: String
    
    init(question: String, answers: [String], correct: Int, explanation: String) {
        self.question = question
        self.answers = answers
        self.correct = correct
        self.explanation = explanation
    }
}
