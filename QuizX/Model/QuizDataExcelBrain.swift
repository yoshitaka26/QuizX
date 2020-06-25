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

}
