//
//  QuizDataExcel.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/12.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct QuizDataExcel: Codable {
    let quizDataSet: [QuizDataSet]
}

struct QuizDataSet: Codable {
    let question: String
    let answer: String
    let a1: String
    let a2: String
    let a3: String
    let a4: String
    let correct: String
}
