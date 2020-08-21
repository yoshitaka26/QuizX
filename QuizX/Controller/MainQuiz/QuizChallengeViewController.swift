//
//  QuizChallengeViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/21.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class QuizChallengeViewController: UIViewController {
    
    //    let db = Firestore.firestore()
    //    var quizDataFSBrain = QuizDataFSBrain()
    
    var quizData: String? = nil
    var quizSetName: String = ""  //初級クイズ１...
    var quizSetNumber: Int = 0  //indexPath.row
    var quizSetArray: [QuizSet] = []
    var quizShuffle: Bool = false
    
    var myQuiz: Bool = false
    var myQuizName: String? = nil
    var myQUizNum: String? = nil
    var myQuizEmail: String? = nil
    
    var userID: String? = nil
    
    let userDefault = UserDefaults.standard
    
    let quizDataExcelBrain = QuizDataExcelBrain()
    
    @IBOutlet weak var myQuizNameLabel: UILabel!
    @IBOutlet weak var QuizChallengeButton: UIButton!
    
    override func viewDidLoad() {
        
        if myQuiz {
            if let name = userID {
                DispatchQueue.main.async {
                    self.myQuizNameLabel.text = "出題者：\(name)さん\n問題数：\(self.quizSetArray.count)問"
                }
            }
        } else {
            if let name = quizData {
                if let qData = quizDataExcelBrain.getQuizDataFromJSONFile(with: name) {
                    quizSetArray.append(contentsOf: qData)
                }
                //            quizDataFSBrain.loadQuizDataFromFS(with: name) { (quizSet) in
                //                self.quizSetArray.append(contentsOf: quizSet)
                //            }
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
                //            quizDataFSBrain.loadQuizDataFromFS(with: K.QData.beginner) { (quizSet) in
                //                self.quizSetArray.append(contentsOf: quizSet)
                //            }
                //            quizDataFSBrain.loadQuizDataFromFS(with: K.QData.intermediate) { (quizSet) in
                //                self.quizSetArray.append(contentsOf: quizSet)
                //            }
                //            quizDataFSBrain.loadQuizDataFromFS(with: K.QData.advanced) { (quizSet) in
                //                self.quizSetArray.append(contentsOf: quizSet)
                //            }
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
            
            if myQuiz {
                destinationVC.myQuiz = true
                destinationVC.myQuizName = myQuizName
                destinationVC.myQUizNum = myQUizNum
                destinationVC.myQuizEmail = myQuizEmail
                
                destinationVC.quizSetArray.append(contentsOf: quizSetArray)
                destinationVC.quizSetName = nil
                destinationVC.quizQNumber = 0
                destinationVC.quizEndQNumber = quizSetArray.count
                destinationVC.navigationItem.hidesBackButton = true
            } else {
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
    
}
