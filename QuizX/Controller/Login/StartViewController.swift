//
//  StartViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/17.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    //    let quizDataFSBrain = QuizDataFSBrain()
    
    //    let quizDataExcelBrain = QuizDataExcelBrain()
    //    var quizDataSetLoaded = [QuizDataSet]()
    
    
    override func viewDidLoad() {
        
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
    
    @IBAction func guestButton(_ sender: UIButton) {
        performSegue(withIdentifier: "loginGuest", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginGuest" {
            let destinationVC = segue.destination as! WelcomViewCntroller
            destinationVC.guestLogin = true
            
        }
    }
}
