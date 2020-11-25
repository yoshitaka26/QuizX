//
//  QuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {
    
    var quizDataName: String? = nil
    var quizNamesArray: [String] = []  //初級クイズ１...
    
    let scoreBrain = ScoreDataRecordBrain()
    var scoreData = [ScoreData]()
    
    
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
        
        cell.quizName.text = quizSetName
        
        cell.scoreLabel.text = "スコア"
        cell.timeLabel.text = "タイム"
        cell.tryLabel.text = "トライ"
        
        for score in scoreData {
            if score.identifier == quizSetName {
                DispatchQueue.main.async {
                    cell.scoreLabel.text = "スコア \(score.totalPoints) / \(score.totalQuizNum)"
                    cell.timeLabel.text = "タイム \(score.totalTime)秒"
                    cell.tryLabel.text = "トライ \(score.challengeCounts)回"
                }
            }
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
