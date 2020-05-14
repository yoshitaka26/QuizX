//
//  QuizTableViewController.swift
//  QuizX
//
//  Created by Yoshitaka on 2020/05/10.
//  Copyright © 2020 Yoshitaka. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {
    
    let quizDataBrain = QuizDataExcelBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
        
        
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
   
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quizDataBrain.quizDataSetNameArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath)
        
        let quizSetName = quizDataBrain.quizDataSetNameArray[indexPath.row]
        
        cell.textLabel?.text = quizSetName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToQuizView", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! QuizViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.quizSetFileName = quizDataBrain.quizDataSetFileNameArray[indexPath.row]
            destinationVC.quizSetNumber = indexPath.row
        }
        
    }
}
