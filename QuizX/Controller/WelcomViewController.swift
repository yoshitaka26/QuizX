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
    @IBOutlet weak var quizXWebButton: UIButton!
    @IBOutlet weak var myQuizButton: UIButton!
    
    
    
    override func viewDidLoad() {
        
        self.navigationItem.hidesBackButton = true
        
        quizButton.layer.cornerRadius = quizButton.frame.size.height / 4
        quizXWebButton.layer.cornerRadius = quizButton.frame.size.height / 4
        
        myQuizButton.layer.cornerRadius = myQuizButton.frame.size.height / 4
        
        let backBarButtonItem = UIBarButtonItem()
              backBarButtonItem.title = ""
              self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    @IBAction func quizButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizSelect", sender: self)
    }
    @IBAction func quizXWebButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "QuizXWeb", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "QuizXWeb")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}



