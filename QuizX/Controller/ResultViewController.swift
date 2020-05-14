//
//  ResultViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit


class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultPointsLabel: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    var totalPoints: Int = 0
    let userDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnButton.setTitle("クイズ一覧へ戻る", for: .normal)
        self.navigationItem.hidesBackButton = true
        resultPointsLabel.text = "\(totalPoints)点"
        let allPoints = userDefault.integer(forKey: "QuizX") + totalPoints
        userDefault.set(allPoints, forKey: "QuizX")
        
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ToQuizSetsList", sender: self)
    }
}
