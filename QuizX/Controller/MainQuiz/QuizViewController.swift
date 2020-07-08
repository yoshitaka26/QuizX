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
    var quizSetName: String? = nil //初級クイズ１...
    var quizSetNumber: Int = 0 //indexPath.row
    var quizQNumber: Int = 0
    var quizEndQNumber: Int = 0
    var totalQuizNum: Int = 10
    var lifePoints = 3
    
    
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
    
    @IBOutlet weak var lifeImage1: UIImageView!
    @IBOutlet weak var lifeImage2: UIImageView!
    @IBOutlet weak var lifeImage3: UIImageView!
    
    var timer = Timer()
    var totalTime: Float = 0
    var secondsPassed: Float = 0
    var answeredTime: Float = 0
    
    var correctPoints: Int = 0
    
    var myQuiz: Bool = false
    var myQuizName: String? = nil
    var myQUizNum: String? = nil
    var myQuizEmail: String? = nil
    
    
    override func viewDidLoad() {
        answerAButton.isEnabled = false
        answerBButton.isEnabled = false
        answerCButton.isEnabled = false
        answerDButton.isEnabled = false
        
        lifeImage1.image = UIImage(systemName: "heart")
        lifeImage2.image = UIImage(systemName: "heart")
        lifeImage3.image = UIImage(systemName: "heart")
        
        totalQuizNum = quizEndQNumber - quizQNumber
        
        quizUpdate(with: quizSetArray, number: quizQNumber)
        
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
                lifePoints -= 1
                if lifePoints == 2 {
                    lifeImage1.image = UIImage(systemName: "heart.slash")
                } else if lifePoints == 1 {
                    lifeImage2.image = UIImage(systemName: "heart.slash")
                } else if lifePoints == 0 {
                    lifeImage3.image = UIImage(systemName: "heart.slash")
                    answeredTime = 0
                    performSegue(withIdentifier: "ToResultView", sender: self)
                }
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
            if quizQNumber < quizEndQNumber - 1 {
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
            destinationVC.quizSetName = quizSetName
            destinationVC.totalQuizNum = totalQuizNum
            destinationVC.totalAnswerdtime = answeredTime
            if myQuiz {
                destinationVC.myQuizName = myQuizName
                destinationVC.myQUizNum = myQUizNum
                destinationVC.myQuizEmail = myQuizEmail
            }
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
        
        answerAButton.setTitle(choices[0], for: .normal)
        answerBButton.setTitle(choices[1], for: .normal)
        answerCButton.setTitle(choices[2], for: .normal)
        answerDButton.setTitle(choices[3], for: .normal)
        
        questionLabel.text = quizSetArray[quizQNumber].question
        
        allButtonON()
        //        questionUpdate()  問題スクロール表示はココを変更
        
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
        if answerAButton.currentTitle != "" {
            answerAButton.isEnabled = true
        }
        if answerBButton.currentTitle != "" {
            answerBButton.isEnabled = true
        }
        if answerCButton.currentTitle != "" {
            answerCButton.isEnabled = true
        }
        if answerDButton.currentTitle != "" {
            answerDButton.isEnabled = true
        }
        
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
    
    
    //MARK: - Question Scroll  問題スクロール表示
    
    func questionUpdate()  {
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
    }
    
}

