//
//  MyQuizScoreData.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/06/25.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct MyQuizScoreData {
    let email: String
    let myQuizNum: String
    let totalpoints: Int
    let totalQuizNum: Int
    let totalTime : Int
}

struct MyQuizData {
    let date: String
    let myQuizNum: String
    let playerEmail: String
    let totalpoints: Int
    let totalQuizNum: Int
}

struct MyQuiz {
    let date: String
    let myQuizName: String
    let myQuizNum: String
    let totalQuizNum: Int
}
