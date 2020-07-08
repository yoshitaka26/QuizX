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
    
    var namesIntermediate: [String] = []
    var namesAdvanced: [String] = []
    var sharedMyQuiz: [String] = []
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var myQuizButton: UIButton!
    @IBOutlet weak var scoreButton: UIButton!
    
    //    let quizDataExcelBrain = QuizDataExcelBrain()
    //    var quizDataSetLoaded = [QuizDataSet]()
    
    override func viewDidLoad() {
        
        self.navigationItem.hidesBackButton = true
        
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
        
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizSelect", sender: self)
    }
    
    @IBAction func myQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToMyQuiz", sender: self)
    }
    
    @IBAction func sharedMyQuizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToSharedMyQuiz", sender: self)
    }
}



