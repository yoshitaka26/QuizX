//
//  WelcomViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/14.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class WelcomViewCntroller: UIViewController {
    
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var myQuizButton: UIButton!
    
    
    
    override func viewDidLoad() {
        
        self.navigationItem.hidesBackButton = true
        
        quizButton.layer.cornerRadius = quizButton.frame.size.height / 4
        
        myQuizButton.layer.cornerRadius = myQuizButton.frame.size.height / 4
        
        let backBarButtonItem = UIBarButtonItem()
              backBarButtonItem.title = ""
              self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizSelect", sender: self)
    }
    
}



