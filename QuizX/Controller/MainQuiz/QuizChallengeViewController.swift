//
//  QuizChallengeViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/21.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class QuizChallengeViewController: UIViewController {
    
    var quizData: String? = nil
    var quizSetName: String = ""  //初級クイズ１...
    var quizSetNumber: Int = 0  //indexPath.row
    var quizSetArray: [QuizDataSet] = []
    var quizShuffle: Bool = false
    
    let userDefault = UserDefaults.standard
    
    let quizDataExcelBrain = QuizDataExcelBrain()
    
    @IBOutlet weak var myQuizNameLabel: UILabel!
    @IBOutlet weak var QuizChallengeButton: UIButton!
    
    override func viewDidLoad() {
        
        if let name = quizData {
            if let qData = quizDataExcelBrain.getQuizDataFromJSONFile(with: name) {
                quizSetArray.append(contentsOf: qData)
            }
        } else {
            if quizSetName == K.QName.challenge {
                if let data = userDefault.array(forKey: quizSetName) as? [Int] {
                    self.myQuizNameLabel.text = "最高スコア \(data[0]) / \(data[1])"
                }
            }
            
            
            if let qDataBeg = quizDataExcelBrain.getQuizDataFromJSONFile(with: K.QData.beginner), let qDataInt = quizDataExcelBrain.getQuizDataFromJSONFile(with: K.QData.intermediate), let qDataAdv = quizDataExcelBrain.getQuizDataFromJSONFile(with: K.QData.advanced) {
                quizSetArray.append(contentsOf: qDataBeg)
                quizSetArray.append(contentsOf: qDataInt)
                quizSetArray.append(contentsOf: qDataAdv)
            }
        }
    }
    
    
    @IBAction func QuizChallengeButton(_ sender: UIButton) {
        
        if quizSetNumber * 10 < quizSetArray.count - 9 {
            performSegue(withIdentifier: "ToQuizView", sender: self)
        } else {
            DispatchQueue.main.async {
                self.QuizChallengeButton.setTitle("クイズ準備中", for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizView" {
            let destinationVC = segue.destination as! QuizViewController
            
            if quizShuffle == false {
                destinationVC.quizSetArray.append(contentsOf: quizSetArray) //{QuiData x 10...}
                destinationVC.quizSetName = quizSetName  //初級クイズ１...
                
                if quizSetNumber == 0 {
                    destinationVC.quizQNumber = 0
                    destinationVC.quizEndQNumber = 10
                } else {
                    let qNum = quizSetNumber * 10
                    destinationVC.quizQNumber = qNum
                    destinationVC.quizEndQNumber = qNum + 10
                }
                destinationVC.navigationItem.hidesBackButton = true
            } else if quizShuffle == true {
                quizSetArray.shuffle()
                destinationVC.quizSetArray.append(contentsOf: quizSetArray)
                destinationVC.quizSetName = K.QName.challenge
                destinationVC.quizQNumber = 0
                destinationVC.quizEndQNumber = quizSetArray.count
                destinationVC.navigationItem.hidesBackButton = true
            }
        }
    }
}
