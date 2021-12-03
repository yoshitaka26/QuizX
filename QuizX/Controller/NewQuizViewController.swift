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
    @IBOutlet weak var shareButton: UIButton!
    
    let quizDataExcelBrain = QuizDataExcelBrain()
    
    private var newQuizSetArray: [NewQuizDataSet] = []
    private var pickedQuiz: NewQuizDataSet? = nil
    private var pickedIndex: Int = 0
    private var stopFlag: Bool = false
    private var slashFlag: Bool = false
    private var needSlashAtEnd: Bool = true
    private var moveToNextFlag: Bool = false
    
    private var questionForShare: String = ""
    private var questionWithSlash: String = ""
    
    override func viewDidLoad() {
        answerNextButton.layer.cornerRadius = answerNextButton.frame.size.height / 4
        shareButton.layer.cornerRadius = shareButton.frame.size.height / 4
        
        if let data = quizDataExcelBrain.getNewQuizDataFromJSONFile() {
            newQuizSetArray = data
            setNewQuiz()
        }
    }
    
    @IBAction func answerNextButtonPressed(_ sender: UIButton) {
        
        if answerNextButton.currentTitle == "Slash" {
            slashFlag = true
            stopFlag = true
            DispatchQueue.main.async {
                self.answerNextButton.setTitle("Answer", for: .normal)
                self.shareButton.isHidden = false
            }
        }
        
        if answerNextButton.currentTitle == "Answer" {
            DispatchQueue.main.async {
                self.answerLabel.text = self.pickedQuiz?.answer ?? ""
                if self.moveToNextFlag {
                    self.questionLabel.text = self.questionWithSlash
                    self.answerNextButton.setTitle("Next", for: .normal)
                } else {
                    self.answerNextButton.setTitle("...", for: .normal)
                }
            }
        }
        
        if answerNextButton.currentTitle == "Next" {
            if moveToNextFlag {
                setNewQuiz()
            }
        }
    }
    
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        var quizXURL = "https://quizx.net/"
        let quizXTag = "#早押しQuizX"
        var text = questionForShare
        
        if let quiz = pickedQuiz {
            quizXURL = quiz.url
        }
        
        text.append("\n\n\(quizXURL)\n\(quizXTag)")
        
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let encodedText = encodedText,
           let url = URL(string: "https://twitter.com/intent/tweet?text=\(encodedText)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    
    func setNewQuiz() {
        if let index = newQuizSetArray.indices.randomElement() {
            pickedIndex = index
        }
        
        pickedQuiz = newQuizSetArray[pickedIndex]
        newQuizSetArray.remove(at: pickedIndex)
        
        answerLabel.text = ""
        questionWithSlash = ""
        let question = pickedQuiz?.question ?? "コンプリート！"
        
        questionUpdate(question)
        
        DispatchQueue.main.async {
            self.answerNextButton.setTitle("Slash", for: .normal)
        }
    }
    
    func questionUpdate(_ question: String)  {
        shareButton.isHidden = true
        
        stopFlag = false
        needSlashAtEnd = true
        moveToNextFlag = false
        
        questionLabel.text = ""
        questionLabel.textAlignment = .left
        var textAfterSlash: String = ""
        var textCheckerForButton: String = ""
        
        var charIndex = 0.0
        
        for letter in question {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                DispatchQueue.main.async {
                    
                    if !self.stopFlag {
                        self.questionLabel.text?.append(letter)
                    } else {
                        textAfterSlash.append(letter)
                        if self.slashFlag {
                            self.questionLabel.text?.append(" / ")
                            self.slashFlag = false
                            self.needSlashAtEnd = false
                            self.questionForShare = self.questionLabel.text ?? ""
                            
                            self.shareButton.isHidden = false
                        }
                    }
                    textCheckerForButton.append(letter)
                    
                    if textCheckerForButton == question {
                        self.moveToNextFlag = true
                        if self.needSlashAtEnd {
                            self.questionLabel.text?.append(" / ")
                            self.questionForShare = self.questionLabel.text ?? ""
                            self.answerNextButton.setTitle("Answer", for: .normal)
                            self.shareButton.isHidden = false
                        }
                        let textBeforeSlash = self.questionLabel.text
                        self.questionWithSlash = textBeforeSlash! + textAfterSlash
                        if self.answerNextButton.currentTitle == "..." {
                            self.questionLabel.text = self.questionWithSlash
                            self.shareButton.isHidden = false
                            DispatchQueue.main.async {
                                self.answerNextButton.setTitle("Next", for: .normal)
                            }
                        }
                    }
                }
            }
            charIndex += 1
        }
    }
}
