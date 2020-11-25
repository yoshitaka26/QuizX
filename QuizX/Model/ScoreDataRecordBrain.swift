//
//  MyQuizDataModel.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/10/13.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct ScoreDataRecordBrain {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ScoreData.plist")
    
    
    func saveScore(projectArray: [ScoreData]) {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(projectArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encording item, \(error)")
        }
    }
    
    func loadScore() -> [ScoreData]? {
        var scoreData = [ScoreData]()
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                scoreData = try decoder.decode([ScoreData].self, from: data)
            } catch {
                print("Error decoding, \(error)")
            }
        }
        return scoreData
    }
    
    mutating func calculateScore(_ totalPoints: Int, _ totalQuizNum: Int, _ scoreName: String, _ totalTime: Int)  {
        var scoreData = [ScoreData]()
        
        if let data = loadScore() {
            scoreData = data
        }
        
        let pickedScoreData = scoreData.filter { $0.identifier == scoreName }
        
        if pickedScoreData.count == 0 {
            let newScore = ScoreData(id: scoreName, totalPoints: totalPoints, totalQuizNum: totalQuizNum, totalTime: totalTime)
            scoreData.append(newScore)
            self.saveScore(projectArray: scoreData)
        } else if pickedScoreData.count == 1 {
            for data in scoreData {
                if data.identifier == scoreName {
                    data.challengeCounts += 1
                    if data.totalTime != 0 {
                        if totalPoints > data.totalPoints {
                            data.totalPoints = totalPoints
                            data.totalTime = totalTime
                        } else if totalPoints == data.totalPoints {
                            if totalTime < data.totalTime {
                                data.totalTime = totalTime
                            }
                        }
                    }
                }
            }
            
            self.saveScore(projectArray: scoreData)
        } else {
            print("データが重複しています")
        }
    }
}
