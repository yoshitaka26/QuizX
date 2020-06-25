//
//  WelcomViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/14.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class WelcomViewCntroller: UIViewController {
    
    let db = Firestore.firestore()
    var quizDataFSBrain = QuizDataFSBrain()
    var namesBeginner: [String] = []
    var namesIntermediate: [String] = []
    var namesAdvanced: [String] = []
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var myQuizButton: UIButton!
    
    @IBOutlet weak var scoreButton: UIButton!
//    let userDefault = UserDefaults.standard
    
    
    
    //    let quizDataExcelBrain = QuizDataExcelBrain()
    //    var quizDataSetLoaded = [QuizDataSet]()
    
    override func viewDidLoad() {
        
        mainLabel.text = "QuizX"
        quizButton.setTitle("クイズ一覧", for: .normal)
        scoreButton.setTitle("成績一覧", for: .normal)
        
        //        quizDataFSBrain.loadQuizDataNameFromFS(with: "quizNamesAdvanced") { (names) in
        //            self.quizNamesArray.append(contentsOf: names)  //語源クイズ１
        //            print(self.quizNamesArray)
        //        }
        
        
        
        
        
        //        let fileNames: [String] = quizDataExcelBrain.quizDataSetFileNameArray
        //        for fileName in fileNames {
        //            if let quizData = quizDataExcelBrain.getQuizDataFromJSONFile(with: fileName) {
        //                quizDataSetLoaded = quizData
        //                quizDataFSBrain.recodeQuizDataToFS(quizDataSetLoaded, fileName)
        //            }
        //        }
        
        quizDataFSBrain.loadQuizDataNameFromFS(with: "quizNamesBeginner") { (names) in
            self.namesBeginner.append(contentsOf: names)  //初級クイズ...
        }
        quizDataFSBrain.loadQuizDataNameFromFS(with: "quizNamesIntermediate") { (names) in
            self.namesIntermediate.append(contentsOf: names)  //中級クイズ...
        }
        quizDataFSBrain.loadQuizDataNameFromFS(with: "quizNamesAdvanced") { (names) in
            self.namesAdvanced.append(contentsOf: names)  //上級クイズ...
        }
    }
    
//    func getPoints() {
//        var point = 0
//        var totalPoint = 0
//        for name in namesBeginner {
//            if let data = userDefault.array(forKey: name) as? [Int] {
//                point += data[0]
//                totalPoint += data[1]
//            }
//        }
//        for name in namesIntermediate {
//            if let data = userDefault.array(forKey: name) as? [Int] {
//                point += data[0]
//                totalPoint += data[1]
//            }
//        }
//        for name in namesAdvanced {
//            if let data = userDefault.array(forKey: name) as? [Int] {
//                point += data[0]
//                totalPoint += data[1]
//            }
//        }
//
//        self.scoreLabel.text = "正解数\n\(point) / \(totalPoint)"
//    }
    
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizSelect", sender: self)
    }
    
    @IBAction func scoreButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToResultView", sender: self)
    }
    
    @IBAction func myQuizButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "ToMyQuiz", sender: self)
        
    }
    
    
    @IBAction func challengeSharedQuiz(_ sender: UIButton) {
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToQuizSelect" {
            let destinationVC = segue.destination as! QuizSelectViewController
            
            destinationVC.namesBeginner.append(contentsOf: namesBeginner)
            destinationVC.namesIntermediate.append(contentsOf: namesIntermediate)
            destinationVC.namesAdvanced.append(contentsOf: namesAdvanced)
        }
        
        if segue.identifier == "ToResultView" {
            let destinationVC = segue.destination as! ResultTableViewController
            
            var allQuizNames = [String]()
            
            allQuizNames.append(contentsOf: namesBeginner)
            allQuizNames.append(contentsOf: namesIntermediate)
            allQuizNames.append(contentsOf: namesAdvanced)
            
            destinationVC.quizNamesArray.append(contentsOf: allQuizNames) //語源クイズ１
        }
    }
}



