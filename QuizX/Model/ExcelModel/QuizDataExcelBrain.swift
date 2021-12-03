//
//  QuizDataExcelBrain.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/13.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct QuizDataExcelBrain {
    
    let quizDataSetFileNameArray = ["quizDataBeginner", "quizDataIntermediate", "quizDataAdvanced"]
    
    let namesBeginner: [String] = ["初級クイズ１", "初級クイズ２", "初級クイズ３", "初級クイズ４", "初級クイズ５", "初級クイズ６", "初級クイズ７", "初級クイズ８"]
    let namesIntermediate: [String] = ["中級クイズ１", "中級クイズ２", "中級クイズ３", "中級クイズ４", "中級クイズ５", "中級クイズ６", "中級クイズ７", "中級クイズ８"]
    let namesAdvanced: [String] = ["上級クイズ１", "上級クイズ２", "上級クイズ３", "上級クイズ４", "上級クイズ５", "上級クイズ６", "上級クイズ７", "上級クイズ８"]
    
    
    func getQuizDataFromJSONFile(with fileName: String) -> [QuizDataSet]? {
        let decoder = JSONDecoder()

        if let path = Bundle.main.url(forResource: fileName, withExtension: "json") {
            if let data = try? Data(contentsOf: path) {
                do {
                    let quizData = try decoder.decode(QuizDataExcel.self, from: data)
                    let quizDataSet = quizData.quizDataSet
                    return quizDataSet
                } catch {
                    print("fail to decode quizData")
                }
            } else {
                print("fail to get Data")
            }
        } else {
            print("fail to get file path to decode")
        }
        return nil
    }
    
    
    func getNewQuizDataFromJSONFile() -> [NewQuizDataSet]? {
        let decoder = JSONDecoder()

        if let path = Bundle.main.url(forResource: "quizData_20211202", withExtension: "json") {
            if let data = try? Data(contentsOf: path) {
                do {
                    let quizData = try decoder.decode(NewQuizDataExcel.self, from: data)
                    let quizDataSet = quizData.quizDataSet
                    return quizDataSet
                } catch {
                    print("fail to decode quizData")
                }
            } else {
                print("fail to get Data")
            }
        } else {
            print("fail to get file path to decode")
        }
        return nil
    }
    
}
