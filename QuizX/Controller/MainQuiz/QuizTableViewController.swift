//
//  QuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {
    
    let userDefault = UserDefaults.standard
    
    var quizDataName: String? = nil
    var quizNamesArray: [String] = []  //初級クイズ１...
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "resultCell")
        
        let backBarButtonItem = UIBarButtonItem()
                    backBarButtonItem.title = ""
                    self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizNamesArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        
        let quizSetName = quizNamesArray[indexPath.row]
        let name = quizSetName
        
        cell.quizName.text = quizSetName
        
        if let data = userDefault.array(forKey: name) as? [Int] {
                cell.scoreLabel.text = "スコア \(data[0]) / \(data[1])"
                cell.timeLabel.text = "タイム \(data[2])秒"
                cell.tryLabel.text = "トライ \(data[3])回"
            }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToQuizChallenge", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToQuizChallenge" {
            let destinationVC = segue.destination as! QuizChallengeViewController
            
            if let name = quizDataName {
                switch name {
                case K.QName.beginner:
                    destinationVC.quizData = K.QData.beginner
                case K.QName.intermediate:
                    destinationVC.quizData = K.QData.intermediate
                case K.QName.advanced:
                    destinationVC.quizData = K.QData.advanced
                default:
                    destinationVC.quizData = nil
                }
            }
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.quizSetName = quizNamesArray[indexPath.row] //初級クイズ１...
                destinationVC.quizSetNumber = indexPath.row
            }
        }
    }
}
