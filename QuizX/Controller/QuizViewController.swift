//
//  ViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    @IBOutlet weak var moveNextButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var timeProgressBar: UIProgressView!
    
    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    var answeredTime: Float = 0
    
    var quizSetFileName: String = ""
    var quizSetNumber: Int = 0
    var quizQNumber: Int = 0
    var correctPoints: Int = 0
    let quizDataExcelBrain = QuizDataExcelBrain()
    var quizDataSetLoaded = [QuizDataSet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let quizData = quizDataExcelBrain.getQuizDataFromJSONFile(with: quizSetFileName) {
            quizDataSetLoaded = quizData
            quizUpdate(with: quizData, number: 0)
        }
        
        
        self.navigationItem.hidesBackButton = true
        
        moveNextButton.isEnabled = false
        
        
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        
        if let selectedAnswer = sender.currentTitle {
            if selectedAnswer == quizDataSetLoaded[quizQNumber].correct {
                sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                correctPoints += 1
                resultLabel.text = "正解"
                answerLabel.text = quizDataSetLoaded[quizQNumber].answer
                allButtonOff()
                
                
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                resultLabel.text = "不正解"
                answerLabel.text = quizDataSetLoaded[quizQNumber].answer
                allButtonOff()
                
            }
        }
        
        moveNextButton.isEnabled = true
        moveNextButton.setTitle("次へ", for: .normal)
    }
    
    @IBAction func moveNextButton(_ sender: UIButton) {
        if questionLabel.text == quizDataSetLoaded[quizQNumber].question {
            if quizQNumber < quizDataSetLoaded.count - 1 {
                quizQNumber += 1
                quizUpdate(with: quizDataSetLoaded, number: quizQNumber)
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
            destinationVC.totalQuizNum = quizDataSetLoaded.count
            destinationVC.totalAnswerdtime = answeredTime
        }
    }
    
    func quizUpdate(with quizDataSet: [QuizDataSet], number: Int) {
        
        let a1 = quizDataSet[number].a1
        let a2 = quizDataSet[number].a2
        let a3 = quizDataSet[number].a3
        let a4 = quizDataSet[number].a4
        var answerArray = [a1, a2, a3, a4]
        answerArray.shuffle()
        
        resultLabel.text = ""
        answerLabel.text = ""
        moveNextButton.setTitle("", for: .normal)
        allButtonON()
        
        answerAButton.setTitle(answerArray[0], for: .normal)
        answerBButton.setTitle(answerArray[1], for: .normal)
        answerCButton.setTitle(answerArray[2], for: .normal)
        answerDButton.setTitle(answerArray[3], for: .normal)
        
        if quizSetNumber == 3 {
            questionLabel.text = ""
            questionLabel.textAlignment = .left
            
            let questionText = quizDataSet[number].question
            
            var charIndex = 0.0
            
            for letter in questionText {
                
                Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                    DispatchQueue.main.async {
                        self.questionLabel.text?.append(letter)
                    }
                }
                charIndex += 1
            }
        } else  {
            questionLabel.text = quizDataSet[number].question
        }
    }
    
    
    
    
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
            answerLabel.text = quizDataSetLoaded[quizQNumber].answer
            allButtonOff()
            moveNextButton.isEnabled = true
            moveNextButton.setTitle("次へ", for: .normal)
        }
    }
}

