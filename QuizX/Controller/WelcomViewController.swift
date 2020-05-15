//
//  WelcomViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/14.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class WelcomViewCntroller: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var scoreButton: UIButton!
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        
        mainLabel.text = "QuizX"
        quizButton.setTitle("クイズ一覧", for: .normal)
        scoreButton.setTitle("成績一覧", for: .normal)
        scoreLabel.text = "\(userDefault.integer(forKey: "QuizX"))🔔"
        
        
    }
    
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizList", sender: self)
    }
    
    @IBAction func scoreButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToResultView", sender: self)
    }
    
}
