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
    
    var totalPoints: Int = 0
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        resultPointsLabel.text = "\(totalPoints)0点"
        
    }
    
}
