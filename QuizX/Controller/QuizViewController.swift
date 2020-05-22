//
//  ViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class QuizViewController: UIViewController {
    
    let db = Firestore.firestore()
    var quizSetArray: [QuizSet] = []
    let quizDataFSBrain = QuizDataFSBrain()
    var quizSetFileName: String = ""
    var quizSetNumber: Int = 0
    var quizQNumber: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    @IBOutlet weak var moveNextButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeProgressBar: UIProgressView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    var answeredTime: Float = 0
    
    var correctPoints: Int = 0
    
    let quizDataExcelBrain = QuizDataExcelBrain()
//    var quizDataSetLoaded = [QuizDataSet]()
    
    override func viewDidLoad() {
        
        
//        if let quizData = quizDataExcelBrain.getQuizDataFromJSONFile(with: quizSetFileName) {
//            quizDataSetLoaded = quizData
//            quizUpdate(with: quizData, number: 0)
////            quizDataFSBrain.recodeQuizDataToFS(quizDataSetLoaded, quizSetFileName)
//            }
        
        quizUpdate(with: quizSetArray, number: 0)
        
        self.navigationItem.hidesBackButton = true
        
        moveNextButton.isEnabled = false
        
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        
        if let selectedAnswer = sender.currentTitle {
            if selectedAnswer == quizSetArray[quizQNumber].answer {
                sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                correctPoints += 1
                resultLabel.text = "正解"
                answerLabel.text = quizSetArray[quizQNumber].explication
                timeLabel.text = "\(Int(secondsPassed))秒"
                allButtonOff()
                
                
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                resultLabel.text = "不正解"
                answerLabel.text = quizSetArray[quizQNumber].explication
                allButtonOff()
                
            }
        }
        
        moveNextButton.isEnabled = true
        moveNextButton.setTitle("次へ", for: .normal)
    }
    
    @IBAction func moveNextButton(_ sender: UIButton) {
        if questionLabel.text == quizSetArray[quizQNumber].question {
            //問題文が全表示されてから次の問題へ進むこと。スクロール表示問題のエラー対策
            if quizQNumber < quizSetArray.count - 1 {
                quizQNumber += 1
                quizUpdate(with: quizSetArray, number: quizQNumber)
            } else {
                performSegue(withIdentifier: "ToResultView", sender: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToResultView" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.totalPoints = correctPoints
            destinationVC.quizSetNumber = quizSetNumber
            destinationVC.totalQuizNum = quizSetArray.count
            destinationVC.totalAnswerdtime = answeredTime
        }
    }
    
    
    //MARK: - Quiz Update
    
    func quizUpdate(with quizDataSet: [QuizSet], number: Int) {
        let currentQuiz = quizDataSet[number]
        var choices = [currentQuiz.answer, currentQuiz.dummy1, currentQuiz.dummy2, currentQuiz.dummy3]
        choices.shuffle()
        
        resultLabel.text = ""
        answerLabel.text = ""
        timeLabel.text = ""
        moveNextButton.setTitle("", for: .normal)
        moveNextButton.isEnabled = false
        allButtonON()
        
        answerAButton.setTitle(choices[0], for: .normal)
        answerBButton.setTitle(choices[1], for: .normal)
        answerCButton.setTitle(choices[2], for: .normal)
        answerDButton.setTitle(choices[3], for: .normal)
        
        questionUpdate()
        
    }
    
    
    func questionUpdate()  {
        switch quizSetNumber {
        case 3:
            questionLabel.text = ""
            questionLabel.textAlignment = .left
            
            let questionText = quizSetArray[quizQNumber].question
            
            var charIndex = 0.0
            
            for letter in questionText {
                
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                    DispatchQueue.main.async {
                        self.questionLabel.text?.append(letter)
                    }
                }
                charIndex += 1
            }
        default:
            questionLabel.text = quizSetArray[quizQNumber].question
        }
    }
    
    
    
    
    //MARK: - Buttons
    
    func allButtonOff() {
        answeredTime += secondsPassed
        timer.invalidate()
        answerAButton.isEnabled = false
        answerBButton.isEnabled = false
        answerCButton.isEnabled = false
        answerDButton.isEnabled = false
    }
    
    func allButtonON() {
        answerAButton.isEnabled = true
        answerBButton.isEnabled = true
        answerCButton.isEnabled = true
        answerDButton.isEnabled = true
        answerAButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerBButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerCButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerDButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        
        setTimer()
    }
    
    
//MARK: - Timer
    
    func setTimer() {
        timer.invalidate()
        
        totalTime = 20.0
        
        timeProgressBar.progress = 0.0
        secondsPassed = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            timeProgressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            resultLabel.text = "タイムアップ"
            answerLabel.text = quizSetArray[quizQNumber].answer
            allButtonOff()
            moveNextButton.isEnabled = true
            moveNextButton.setTitle("次へ", for: .normal)
        }
    }
}

