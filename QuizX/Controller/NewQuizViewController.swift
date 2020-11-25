//
//  NewQuizViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/11/25.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class NewQuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerNextButton: UIButton!
    
    let quizDataExcelBrain = QuizDataExcelBrain()
    
    private var newQuizSetArray: [NewQuizDataSet] = []
    private var pickedQuiz: NewQuizDataSet? = nil
    private var pickedIndex: Int = 0
    private var slashFlag: Bool = false
    private var textShowedFlag: Bool = false
    
    var buttonFlag: Bool {
        get {
            return true
        }
        
        set {
            if answerNextButton.currentTitle == "次へ" {
                answerNextButton.isEnabled = newValue
            } else {
                textShowedFlag = true
            }
        }
    }
    
    override func viewDidLoad() {
        answerNextButton.layer.cornerRadius = answerNextButton.frame.size.height / 4
        
        
        if let data = quizDataExcelBrain.getNewQuizDataFromJSONFile() {
            newQuizSetArray = data
            setNewQuiz()
        }
    }
    
    @IBAction func answerNextButtonPressed(_ sender: UIButton) {
        if answerNextButton.currentTitle == "答え" {
            slashFlag = true
            
            DispatchQueue.main.async {
                self.answerLabel.text = self.pickedQuiz?.a ?? ""
                self.answerNextButton.setTitle("次へ", for: .normal)
                if !self.textShowedFlag {
                    self.buttonFlag = false
                } else {
                    self.buttonFlag = true
                }
            }
        }
        
        if answerNextButton.currentTitle == "次へ" {
            setNewQuiz()
        }
    }
    
    
    func setNewQuiz() {
        if let index = newQuizSetArray.indices.randomElement() {
            pickedIndex = index
        }
        
        pickedQuiz = newQuizSetArray[pickedIndex]
        newQuizSetArray.remove(at: pickedIndex)
        
        let question = pickedQuiz?.q ?? ""
        
        questionUpdate(question)
        
        answerLabel.text = ""
        
        answerNextButton.setTitle("答え", for: .normal)
    }
    
    func questionUpdate(_ question: String)  {
        slashFlag = false
        textShowedFlag = false
        
        questionLabel.text = ""
        questionLabel.textAlignment = .left
        var textCheckerForButton: String = ""
        
        var charIndex = 0.0
        
        for letter in question {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                DispatchQueue.main.async {
                    if self.slashFlag {
                        self.questionLabel.text?.append(" ／ ")
                        self.slashFlag = false
                    }
                    
                    self.questionLabel.text?.append(letter)
                    
                    if textCheckerForButton == question {
                        self.buttonFlag = true
                    }
                }
                textCheckerForButton.append(letter)
            }
            charIndex += 1
        }
    }
}
