//
//  ViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerAButton: UIButton!
    @IBOutlet weak var answerBButton: UIButton!
    @IBOutlet weak var answerCButton: UIButton!
    @IBOutlet weak var answerDButton: UIButton!
    @IBOutlet weak var moveNextButton: UIButton!
    
    let quizBrain = QuizBrain()
    var quizNumber: Int = 0
    var correctPoints: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizUpdate()
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        
        if let selectedAnswer = sender.currentTitle {
            let correctAnswer = quizBrain.FirstQuizSet[quizNumber].correct
            if selectedAnswer == quizBrain.FirstQuizSet[quizNumber].answers[correctAnswer] {
                sender.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                sender.setTitle("正解", for: .normal)
                correctPoints += 1
                answerLabel.text = quizBrain.FirstQuizSet[quizNumber].explanation
                
            } else {
                sender.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
                answerLabel.text = quizBrain.FirstQuizSet[quizNumber].explanation
            }
        }
        moveNextButton.setTitle("次へ", for: .normal)
    }
    
    @IBAction func moveNextButton(_ sender: UIButton) {
        
        if quizNumber < 2 {
            quizNumber += 1
            quizUpdate()
        } else {
            performSegue(withIdentifier: "ToResultView", sender: self)
        }
  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToResultView" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.totalPoints = correctPoints
        }
        
    }
    
    
    
    func quizUpdate() {
        
        questionLabel.text = quizBrain.FirstQuizSet[quizNumber].question
        answerLabel.text = ""
        moveNextButton.setTitle("", for: .normal)
        
        answerAButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerBButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerCButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerDButton.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        answerAButton.setTitle(quizBrain.FirstQuizSet[quizNumber].answers[0], for: .normal)
        answerBButton.setTitle(quizBrain.FirstQuizSet[quizNumber].answers[1], for: .normal)
        answerCButton.setTitle(quizBrain.FirstQuizSet[quizNumber].answers[2], for: .normal)
        answerDButton.setTitle(quizBrain.FirstQuizSet[quizNumber].answers[3], for: .normal)
        
    }
}

