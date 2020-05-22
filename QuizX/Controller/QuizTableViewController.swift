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
    var quizSetArray: [QuizSet] = []
    var quizNamesArray: [String] = []
    
    let quizDataBrain = QuizDataExcelBrain()
    let quizNames: [String] = QuizName().quizName
    
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
        if indexPath.row != quizDataBrain.quizDataSetNameArray.count {
            
            performSegue(withIdentifier: "ToQuizChallenge", sender: self)
            
        } else {
            performSegue(withIdentifier: "ToResult", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToQuizChallenge" {
            let destinationVC = segue.destination as! QuizChallengeViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                quizDataFSBrain.loadQuizDataFromFS(with: quizNames[indexPath.row]) { (quizSet) in
                    self.quizSetArray.append(contentsOf: quizSet)
                    destinationVC.quizSetArray.append(contentsOf: quizSet)
                }
                destinationVC.quizSetFileName = quizNames[indexPath.row]
                destinationVC.quizSetNumber = indexPath.row
            }
        }
        else if segue.identifier == "ToResult" {
            let destinationVC = segue.destination as! ResultTableViewController
            
            destinationVC.quizNamesArray.append(contentsOf: quizNamesArray)
        }
    }
}
