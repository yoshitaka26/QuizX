//
//  QuizDataExcelBrain.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/13.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct QuizDataExcelBrain {
    
    let quizDataSetFileNameArray = ["quizData1_1", "quizData1_2", "quizData1_3", "quizData2_1"]
    let quizDataSetNameArray = ["語源クイズ１", "語源クイズ２", "語源クイズ３", "早押しクイズ１"]
    
    var pointDictionary: [String: Int] = ["語源クイズ１p": 0, "語源クイズ２p": 0, "語源クイズ３p": 0, "早押しクイズ１p": 0]
    var scoreDictionary: [String: String] = ["語源クイズ１": "", "語源クイズ２": "", "語源クイズ３": "", "早押しクイズ１": ""]
    var timeDictionary: [String: Int] = ["語源クイズ１t": 0, "語源クイズ２t": 0, "語源クイズ３t": 0, "早押しクイズ１t": 0]
    
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
