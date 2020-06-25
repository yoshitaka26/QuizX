//
//  QuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit
import Firebase

class QuizTableViewController: UITableViewController {
    
    let db = Firestore.firestore()

    var quizDataFSBrain = QuizDataFSBrain()
    var quizNamesArray: [String] = []  //初級クイズ１...
    var quizSetArray: [QuizSet] = [] //{QuiData x 75...}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
    
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quizNamesArray.count + 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != quizNamesArray.count {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            
            let quizSetName = quizNamesArray[indexPath.row]
            
            cell.textLabel?.text = quizSetName
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
            
            cell.textLabel?.text = "成績一覧へ"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != quizNamesArray.count {
            
            performSegue(withIdentifier: "ToQuizChallenge", sender: self)
            
        } else {
            performSegue(withIdentifier: "ToResult", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToQuizChallenge" {
            let destinationVC = segue.destination as! QuizChallengeViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                //quizData1_1 -> {QuizData x 5.10...}
                destinationVC.quizSetArray = quizSetArray
                destinationVC.quizSetName = quizNamesArray[indexPath.row] //初級クイズ１...
                destinationVC.quizSetNumber = indexPath.row  //{QuizDataSet} -> 0-4...
            }
        }
        else if segue.identifier == "ToResult" {
            let destinationVC = segue.destination as! ResultTableViewController
            
            destinationVC.quizNamesArray.append(contentsOf: quizNamesArray)  //初級クイズ１...
        }
    }
}
