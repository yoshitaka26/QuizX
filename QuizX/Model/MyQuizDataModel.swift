//
//  MyQuizDataModel.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/10/13.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import Foundation

struct MyQuizDataModel {
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("MyQuizData.plist")

    
    func saveItems(projectArray: [QuizDataSet]) {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(projectArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encording item, \(error)")
        }
    }
    
    func loadItems() -> [QuizDataSet]? {
        var projectArray = [QuizDataSet]()
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                projectArray = try decoder.decode([QuizDataSet].self, from: data)
            } catch {
                print("Error decoding, \(error)")
            }
        }
        return projectArray
    }
}
