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
    
    let answer: String
    let dummy1: String
    let dummy2: String
    let dummy3: String
    let explication: String
    let question: String
    
}

struct NewQuizDataExcel: Codable {
    let quizDataSet: [NewQuizDataSet]
}

struct NewQuizDataSet: Codable {
    let q: String
    let a: String
}


